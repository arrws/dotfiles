import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import {
  createEditTool,
  createEditToolDefinition,
  createBashToolDefinition,
  createReadTool,
  createReadToolDefinition,
} from "@earendil-works/pi-coding-agent";
import { Container, Text } from "@earendil-works/pi-tui";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";

/**
 * Render diffs through the real `delta` binary (your gitconfig [delta]/xtheme
 * settings apply automatically), fully replacing pi's built-in diff views.
 *
 *  - `edit` tool: result renders ONLY through delta (no built-in preview).
 *  - `bash` tool: when command output is a diff (`git diff`, `diff -u`, ...),
 *    render it through delta; otherwise keep pi's normal output view.
 *
 * Execution behavior is unchanged — both tools delegate to the real built-ins.
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

  // ---- `edit` override: header only + delta result ----------------------

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
      // Delegate to the real built-in edit tool: identical validation,
      // backups, mutation queue, and details.patch computation.
      return createEditTool(ctx.cwd).execute(toolCallId, params, signal, onUpdate);
    },
    renderCall(args, theme, context) {
      const text =
        context.lastComponent instanceof Text ? context.lastComponent : new Text("", 0, 0);
      const p = shortenPath((args as { file_path?: string; path?: string })?.file_path ?? (args as { path?: string })?.path);
      text.setText(`${theme.fg("border", theme.bold("edit"))} ${theme.fg("accent", p)}`);
      return text;
    },
    renderResult(result, _options, theme, context) {
      const component = context.lastComponent ?? new Container();
      component.clear();
      if (context.isError) {
        const errText = (result.content || [])
          .filter((c) => c.type === "text")
          .map((c) => (c as { text?: string }).text || "")
          .join("\n");
        if (errText) {
          component.addChild(new Text(theme.fg("error", errText), 1, 0));
        }
        return component;
      }
      const patch = (result as { details?: { patch?: string } }).details?.patch;
      if (!patch) return component;
      const styled = renderDelta(patch);
      component.addChild(new Text(styled ?? theme.fg("muted", "(diff unavailable)"), 1, 0));
      return component;
    },
  });

  // ---- `bash` override: delta for diff output, built-in otherwise ------

  pi.registerTool({
    name: "bash",
    label: "bash",
    renderShell: "self",
    description: createBashToolDefinition(process.cwd()).description,
    parameters: createBashToolDefinition(process.cwd()).parameters,
    async execute(toolCallId, params, signal, onUpdate, ctx) {
      // Delegate to the real built-in bash tool, honoring shell settings.
      const { shellPath, commandPrefix } = readShellSettings(ctx.cwd);
      return createBashToolDefinition(ctx.cwd, { shellPath, commandPrefix }).execute(
        toolCallId,
        params,
        signal,
        onUpdate,
        ctx,
      );
    },
    renderCall(args, _theme, context) {
      return createBashToolDefinition(context.cwd).renderCall!(args, _theme, context);
    },
    renderResult(result, options, theme, context) {
      const base = createBashToolDefinition(context.cwd);
      const partial = options.isPartial;
      const truncated = !!(result as { details?: { truncation?: unknown } }).details?.truncation;
      const text = (result.content || [])
        .filter((c) => c.type === "text")
        .map((c) => (c as { text?: string }).text || "")
        .join("\n");
      if (!partial && !context.isError && !truncated && looksLikeDiff(text)) {
        const styled = renderDelta(text);
        if (styled) {
          const component = context.lastComponent ?? new Container();
          component.clear();
          component.addChild(new Text(styled, 1, 0));
          return component;
        }
      }
      // Non-diff output: keep pi's normal view (command header, exit code, timer).
      return base.renderResult!(result, options, theme, context);
    },
  });

  // ---- `read` override: blue title + no background card -----------------

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
      const text =
        context.lastComponent instanceof Text ? context.lastComponent : new Text("", 0, 0);
      const p = shortenPath((args as { path?: string })?.path);
      text.setText(`${theme.fg("border", theme.bold("read"))} ${theme.fg("accent", p)}`);
      return text;
    },
    renderResult(result, options, theme, context) {
      return createReadToolDefinition(context.cwd).renderResult!(
        result,
        options,
        theme,
        context,
      );
    },
  });
}
