import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import {
  createEditTool,
  createEditToolDefinition,
  createBashToolDefinition,
  createReadTool,
  createReadToolDefinition,
  createWriteTool,
  createWriteToolDefinition,
  createGrepToolDefinition,
  createFindToolDefinition,
  createLsToolDefinition,
  Theme,
} from "@earendil-works/pi-coding-agent";
import { Text, type Component } from "@earendil-works/pi-tui";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";
import {
  borderShell,
  statusColor,
  withBorder,
} from "./_shared/tool-border";

/**
 * Render diffs through the real `delta` binary (your gitconfig [delta]/xtheme
 * settings apply automatically), fully replacing pi's built-in diff views.
 *
 *  - `edit` tool: result renders ONLY through delta (no built-in preview).
 *  - `bash` tool: when command output is a diff (`git diff`, `diff -u`, ...),
 *    render it through delta; otherwise keep pi's normal output view.
 *
 * Execution behavior is unchanged — all tools delegate to the real built-ins.
 * Every tool renders inside the shared left status border (see
 * `_shared/tool-border.ts`) instead of pi's background `Box`.
 */
export default function (pi: ExtensionAPI) {
  // ---- shared helpers ---------------------------------------------------

  function renderDelta(input: string): string | null {
    try {
      const width = Math.max(40, (process.stdout.columns ?? 120) - 6);
      const out = execFileSync("delta", ["--width", String(width), "--file-style", "omit"], {
        input,
        encoding: "utf8",
        maxBuffer: 20 * 1024 * 1024,
      });
      const trimmed = out.replace(/\n+$/, "");
      return trimmed.trim() ? trimmed : null;
    } catch {
      return null; // delta missing/failed -> caller falls back
    }
  }

  function shortenPath(p?: string): string {
    if (!p) return "";
    const h = homedir();
    return p.startsWith(h) ? "~" + p.slice(h.length) : p;
  }

  function looksLikeDiff(text: string): boolean {
    if (!text) return false;
    return (
      /^diff --git /m.test(text) ||
      /^@@ .*@@/m.test(text) ||
      (/^--- /m.test(text) && /^\+\+\+ /m.test(text))
    );
  }

  function readShellSettings(cwd: string) {
    const tryRead = (p: string) => {
      try {
        return JSON.parse(readFileSync(p, "utf8")) as Record<string, unknown>;
      } catch {
        return {};
      }
    };
    const merged = {
      ...tryRead(join(homedir(), ".pi", "agent", "settings.json")),
      ...tryRead(join(cwd, ".pi", "settings.json")),
    };
    return {
      shellPath: (merged.shellPath as string | undefined) ?? undefined,
      commandPrefix: (merged.shellCommandPrefix as string | undefined) ?? undefined,
    };
  }

  function formatBashCallLine(
    args: { command?: unknown; timeout?: number },
    theme: Theme,
  ): string {
    const raw = args?.command;
    const command = raw == null ? "" : String(raw);
    const timeoutSuffix = args?.timeout ? theme.fg("muted", ` (timeout ${args.timeout}s)`) : "";
    const commandDisplay = command ? command : theme.fg("toolOutput", "...");
    // Blue `>` prompt (non-bold); command text white (default tool-title color).
    const prompt = theme.fg("borderAccent", ">");
    return `${prompt} ${theme.fg("toolTitle", commandDisplay)}${timeoutSuffix}`;
  }

  // Recolor only the leading built-in title word for `write`. The built-in
  // renders the name via theme.fg("toolTitle", theme.bold("write")); we re-emit
  // it in blue, leaving path + content preview + highlight cache intact. Reads
  // the runtime-public `.text` field to avoid reimplementing the call renderer.
  function recolorTitleWord(component: Text, oldTitle: string, newTitle: string): void {
    const c = component as unknown as { text: string; setText: (s: string) => void };
    if (c.text.startsWith(oldTitle)) {
      c.setText(newTitle + c.text.slice(oldTitle.length));
    }
  }

  // ---- `edit` override: border + delta result --------------------------

  pi.registerTool({
    name: "edit",
    label: "edit",
    renderShell: "self",
    description:
      "Edit a single file using exact text replacement. Every edits[].oldText must match a unique, non-overlapping region of the original file. If two changes affect the same block or nearby lines, merge them into one edit instead of emitting overlapping edits. Do not include large unchanged regions just to connect distant changes.",
    promptSnippet:
      "Make precise file edits with exact text replacement, including multiple disjoint edits in one call",
    promptGuidelines: [
      "Use edit for precise changes (edits[].oldText must match exactly)",
      "When changing multiple separate locations in one file, use one edit call with multiple entries in edits[] instead of multiple edit calls",
      "Each edits[].oldText is matched against the original file, not after earlier edits are applied. Do not emit overlapping or nested edits. Merge nearby changes into one edit.",
      "Keep edits[].oldText as small as possible while still being unique in the file. Do not pad with large unchanged regions.",
    ],
    parameters: createEditToolDefinition(process.cwd()).parameters,
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      return createEditTool(ctx.cwd).execute(toolCallId, params, signal, onUpdate);
    },
    renderCall(args, theme, context) {
      const shell = borderShell(context, theme, statusColor(context.isPartial, context.isError));
      const p = shortenPath(
        (args as { file_path?: string; path?: string })?.file_path ??
          (args as { path?: string })?.path,
      );
      shell.clear();
      shell.addChild(
        new Text(`${theme.fg("borderAccent", "edit")} ${theme.fg("accent", p)}`, 0, 0),
      );
      return shell;
    },
    renderResult(result, options, theme, context) {
      const shell = borderShell(context, theme, statusColor(options.isPartial, context.isError));
      shell.clear();
      if (context.isError) {
        const errText = (result.content || [])
          .filter((c) => c.type === "text")
          .map((c) => (c as { text?: string }).text || "")
          .join("\n");
        if (errText) shell.addChild(new Text(theme.fg("error", errText), 0, 0));
        return shell;
      }
      const patch = (result as { details?: { patch?: string } }).details?.patch;
      if (!patch) return shell;
      const styled = renderDelta(patch);
      shell.addChild(new Text(styled ?? theme.fg("muted", "(diff unavailable)"), 0, 0));
      return shell;
    },
  });

  // ---- `bash` override: border, delta for diff output ------------------

  pi.registerTool({
    name: "bash",
    label: "bash",
    renderShell: "self",
    description: createBashToolDefinition(process.cwd()).description,
    parameters: createBashToolDefinition(process.cwd()).parameters,
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      const { shellPath, commandPrefix } = readShellSettings(ctx.cwd);
      return createBashToolDefinition(ctx.cwd, { shellPath, commandPrefix }).execute(
        toolCallId,
        params,
        signal,
        onUpdate,
        ctx,
      );
    },
    renderCall(args, theme, context) {
      // Stamp the execution start time so the built-in's elapsed/"Took" timer keeps working.
      const state = context.state as { startedAt?: number; endedAt?: number };
      if (context.executionStarted && state.startedAt === undefined) {
        state.startedAt = Date.now();
        state.endedAt = undefined;
      }
      const shell = borderShell(context, theme, statusColor(context.isPartial, context.isError));
      shell.clear();
      shell.addChild(
        new Text(formatBashCallLine(args as { command?: unknown; timeout?: number }, theme), 0, 0),
      );
      return shell;
    },
    renderResult(result, options, theme, context) {
      const base = createBashToolDefinition(context.cwd);
      const partial = options.isPartial;
      const truncated = !!(result as { details?: { truncation?: unknown } }).details?.truncation;
      const text = (result.content || [])
        .filter((c) => c.type === "text")
        .map((c) => (c as { text?: string }).text || "")
        .join("\n");
      const color = statusColor(partial, context.isError);
      const isDiff = !partial && !context.isError && !truncated && looksLikeDiff(text);

      // Diff output: render through delta inside the border.
      if (isDiff) {
        const styled = renderDelta(text);
        if (styled) {
          const shell = borderShell(context, theme, color);
          shell.clear();
          shell.addChild(new Text(styled, 0, 0));
          return shell;
        }
      }

      // Normal output (or delta fallback): let the built-in build its own
      // component (reused across renders via stashed state, preserving its
      // line-truncation cache + elapsed timer), then wrap it in the border
      // gutter. The built-in must NOT be handed the GutterShell as
      // lastComponent — it expects a BashResultRenderComponent (.state) and
      // would crash, making pi fall back to a bar-less render.
      const state = context.state as { resultInner?: Component | undefined };
      const inner = base.renderResult!(result, options, theme, {
        ...context,
        lastComponent: state.resultInner,
      });
      state.resultInner = inner;
      const shell = borderShell(context, theme, color);
      shell.clear();
      shell.addChild(inner);
      return shell;
    },
  });

  // ---- `write` override: border, recolored title -----------------------

  pi.registerTool({
    name: "write",
    label: "write",
    renderShell: "self",
    description: createWriteToolDefinition(process.cwd()).description,
    parameters: createWriteToolDefinition(process.cwd()).parameters,
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      return createWriteTool(ctx.cwd).execute(toolCallId, params, signal, onUpdate);
    },
    renderCall(args, theme, context) {
      // Delegate to the built-in call renderer (preserves content preview +
      // incremental syntax-highlight cache), reusing the inner component via
      // shared state, then recolor the title word blue.
      const shell = borderShell(context, theme, statusColor(context.isPartial, context.isError));
      shell.clear();
      const def = createWriteToolDefinition(context.cwd);
      const state = context.state as { innerCall?: Text | undefined };
      const inner = def.renderCall!(args, theme, {
        ...context,
        lastComponent: state.innerCall,
      }) as Text;
      state.innerCall = inner;
      recolorTitleWord(
        inner,
        theme.fg("toolTitle", theme.bold("write")),
        theme.fg("borderAccent", "write"),
      );
      shell.addChild(inner);
      return shell;
    },
    renderResult(result, options, theme, context) {
      const def = createWriteToolDefinition(context.cwd);
      const inner = def.renderResult!(result, options, theme, {
        ...context,
        lastComponent: undefined,
      } as typeof context);
      const shell = borderShell(context, theme, statusColor(options.isPartial, context.isError));
      shell.clear();
      shell.addChild(inner);
      return shell;
    },
  });

  // ---- `read` override: border + built-in result -----------------------

  pi.registerTool({
    name: "read",
    label: "read",
    renderShell: "self",
    description: createReadToolDefinition(process.cwd()).description,
    parameters: createReadToolDefinition(process.cwd()).parameters,
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      return createReadTool(ctx.cwd).execute(toolCallId, params, signal, onUpdate);
    },
    renderCall(args, theme, context) {
      const shell = borderShell(context, theme, statusColor(context.isPartial, context.isError));
      const p = shortenPath((args as { path?: string })?.path);
      shell.clear();
      shell.addChild(
        new Text(`${theme.fg("borderAccent", "read")} ${theme.fg("accent", p)}`, 0, 0),
      );
      return shell;
    },
    renderResult(result, options, theme, context) {
      const def = createReadToolDefinition(context.cwd);
      const inner = def.renderResult!(result, options, theme, {
        ...context,
        lastComponent: undefined,
      } as typeof context);
      const shell = borderShell(context, theme, statusColor(options.isPartial, context.isError));
      shell.clear();
      shell.addChild(inner);
      return shell;
    },
  });

  // ---- read-only tools: border via the generic wrapper -----------------

  pi.registerTool(withBorder(createGrepToolDefinition(process.cwd())));
  pi.registerTool(withBorder(createFindToolDefinition(process.cwd())));
  pi.registerTool(withBorder(createLsToolDefinition(process.cwd())));
}
