/**
 * Shared left-status-border styling for pi tools.
 *
 * Replaces pi's default `Box` background (`toolSuccessBg`/`toolErrorBg`/…)
 * with a colored vertical bar (▎) down the left edge of every rendered line —
 * the per-line transform mirrors `Box.applyBg`, but emits a status gutter
 * instead of a fill.
 *
 * `withBorder()` is a rendering-only wrapper: it sets `renderShell: "self"`
 * and wraps a tool's own `renderCall`/`renderResult` output in a `GutterShell`.
 * Execution (`execute`) and prompt metadata are passed through untouched.
 *
 * Not loaded as an extension (no default export / index.ts) — imported by
 * other extensions via a relative path.
 */
import type { Component } from "@earendil-works/pi-tui";
import { Container, Text } from "@earendil-works/pi-tui";
import {
  Theme,
  type ThemeColor,
  type ToolDefinition,
  type ToolRenderContext,
  type ToolRenderResultOptions,
} from "@earendil-works/pi-coding-agent";

// ---- geometry / palette -----------------------------------------------

const GUTTER_WIDTH = 2; // bar (1) + gap (1)
const BAR_CHAR = "\u258e"; // ▎ left one-quarter block

// Muted green for the success bar — desaturated and dimmed relative to delta's
// vivid #00dd00 additions, clearly "success" without being loud.
const SUCCESS_BAR_COLOR = "#4f8f4f";
// Muted yellow for the pending bar — far less saturated than the #ffff00
// `warning` theme token; tuned to the green's lightness/chroma.
const PENDING_BAR_COLOR = "#bfae50";

/** Status color for the left bar, given the render outcome. */
export function statusColor(isPartial: boolean, isError: boolean): string {
  if (isPartial) return PENDING_BAR_COLOR; // in-flight -> muted yellow
  if (isError) return "error"; // failed -> red (theme token)
  return SUCCESS_BAR_COLOR; // success -> muted green
}

// ---- color emission ----------------------------------------------------

function rawFg(theme: Theme, hex: string, text: string): string {
  const clean = hex.replace("#", "");
  const r = parseInt(clean.slice(0, 2), 16);
  const g = parseInt(clean.slice(2, 4), 16);
  const b = parseInt(clean.slice(4, 6), 16);
  if (theme.getColorMode() === "truecolor") {
    return `\x1b[38;2;${r};${g};${b}m${text}\x1b[39m`;
  }
  // 256-color fallback: nearest 6x6x6 cube index (mirrors pi's hexTo256).
  const cube = [0, 95, 135, 175, 215, 255];
  const near = (v: number) => {
    let best = 0;
    let bestDist = Infinity;
    for (let i = 0; i < cube.length; i++) {
      const d = Math.abs(v - cube[i]);
      if (d < bestDist) {
        bestDist = d;
        best = i;
      }
    }
    return best;
  };
  const idx = 16 + 36 * near(r) + 6 * near(g) + near(b);
  return `\x1b[38;5;${idx}m${text}\x1b[39m`;
}

/** Style text in a color that is either a theme token (theme.fg) or raw #hex. */
export function colored(theme: Theme, color: string, text: string): string {
  return color.startsWith("#") ? rawFg(theme, color, text) : theme.fg(color as ThemeColor, text);
}

/** Gutter prefix builder: colored status bar down the left edge. */
export function barPrefix(color: string): (t: Theme) => string {
  return (t) => `${colored(t, color, BAR_CHAR)} `;
}

// ---- GutterShell -------------------------------------------------------

/**
 * Container that prefixes every rendered line with a fixed-width gutter.
 * Owns no styling of its own; the caller configures the prefix via
 * {@link configure}. The full `Container` surface (`addChild`/`clear`/…) is
 * preserved so pi's built-in renderers can repopulate it directly.
 */
export class GutterShell extends Container {
  private theme?: Theme;
  private buildPrefix: (t: Theme) => string = () => " ".repeat(GUTTER_WIDTH);

  configure(theme: Theme, buildPrefix: (t: Theme) => string): void {
    this.theme = theme;
    this.buildPrefix = buildPrefix;
  }

  render(width: number): string[] {
    const contentWidth = Math.max(1, width - GUTTER_WIDTH);
    const prefix = this.theme ? this.buildPrefix(this.theme) : " ".repeat(GUTTER_WIDTH);
    const out: string[] = [];
    for (const child of this.children) {
      for (const line of child.render(contentWidth)) {
        out.push(prefix + line);
      }
    }
    return out;
  }
}

/** Reuse-or-create a `GutterShell` (via `lastComponent`) configured with `color`'s bar. */
export function borderShell(
  context: { lastComponent?: unknown },
  theme: Theme,
  color: string,
): GutterShell {
  const shell =
    context.lastComponent instanceof GutterShell ? context.lastComponent : new GutterShell();
  shell.configure(theme, barPrefix(color));
  return shell;
}

// ---- generic wrapper ---------------------------------------------------

type AnyToolDef = ToolDefinition<any, any, any>;

// State keys are namespaced to avoid colliding with built-in renderers that
// also read/write the shared `context.state` (e.g. bash's startedAt/interval).
const CALL_INNER = "__border_call_inner";
const RESULT_INNER = "__border_result_inner";

/** Blue tool-name title plus the first string argument (e.g. a query/path), for tools without a renderer. */
function fallbackTitle(def: AnyToolDef, args: unknown, theme: Theme): string {
  const name = theme.fg("borderAccent", (def.label || def.name).toLowerCase());
  const extra = firstStringArg(args);
  return extra ? `${name} ${theme.fg("accent", extra)}` : name;
}

function firstStringArg(args: unknown): string {
  if (!args || typeof args !== "object") return "";
  for (const v of Object.values(args as Record<string, unknown>)) {
    if (typeof v === "string" && v.trim()) {
      return v.length > 60 ? `${v.slice(0, 57)}...` : v;
    }
  }
  return "";
}

/** Raw text from a result's content (errors colored red). Empty -> undefined. */
function fallbackResultText(
  result: { content?: Array<{ type: string; text?: string }>; isError?: boolean },
  theme: Theme,
): string | undefined {
  const text = (result.content || [])
    .filter((c) => c.type === "text")
    .map((c) => c.text || "")
    .join("\n")
    .trim();
  if (!text) return undefined;
  return result.isError ? theme.fg("error", text) : text;
}

/**
 * Wrap a tool definition so it renders inside the left status border instead
 * of pi's default background `Box`. Rendering-only: `execute` and prompt
 * metadata are passed through.
 *
 * Tools with their own `renderCall`/`renderResult` keep that output (wrapped
 * in the gutter). Tools without renderers get a synthesized blue title line
 * and raw result text, mirroring pi's built-in fallbacks.
 */
export function withBorder<T extends AnyToolDef>(def: T): T {
  const wrapped: AnyToolDef = {
    ...def,
    renderShell: "self",
    renderCall(args, theme, context) {
      const shell = borderShell(context, theme, statusColor(context.isPartial, context.isError));
      shell.clear();
      const state = context.state as Record<string, Component | undefined>;
      const inner = def.renderCall
        ? def.renderCall(args, theme, withInner(context, state[CALL_INNER]))
        : new Text(fallbackTitle(def, args, theme), 0, 0);
      state[CALL_INNER] = inner;
      shell.addChild(inner);
      return shell;
    },
    renderResult(result, options, theme, context) {
      const shell = borderShell(context, theme, statusColor(options.isPartial, context.isError));
      shell.clear();
      const state = context.state as Record<string, Component | undefined>;
      let inner: Component;
      if (def.renderResult) {
        inner = def.renderResult(result, options, theme, withInner(context, state[RESULT_INNER]));
      } else {
        const text = fallbackResultText(result, theme);
        inner = text ? new Text(text, 0, 0) : new Container();
      }
      state[RESULT_INNER] = inner;
      shell.addChild(inner);
      return shell;
    },
  };
  return wrapped as T;
}

/** Clone a render context, overriding `lastComponent` for inner-renderer reuse. */
function withInner<TState, TArgs>(
  context: ToolRenderContext<TState, TArgs>,
  lastComponent: Component | undefined,
): ToolRenderContext<TState, TArgs> {
  return { ...context, lastComponent };
}

// Keep option/result types referenced for downstream consumers.
export type { ToolRenderResultOptions };
