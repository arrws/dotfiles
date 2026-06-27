/**
 * Two layout fixes for pi's interactive mode:
 *
 * 1. Slash-command autocomplete (`/commands`) renders ABOVE the input box
 *    instead of below it (so opening it never grows the editor downward into
 *    the footer).
 *
 * 2. The editor + footer are pinned to the bottom of the terminal window.
 *
 * Both symptoms share one root cause: pi-tui lays out content strictly
 * top-down with no flexible spacer, so when total content is shorter than the
 * terminal (or changes height — e.g. an autocomplete menu opening/closing),
 * the footer drifts. We patch `tui.render` to insert a flex filler between the
 * top block (header / chat / status / widgets-above) and the bottom block
 * (editor / widgets-below / footer) sized so the bottom block always lands on
 * the last terminal row. Each child is still rendered exactly once.
 */
import { CustomEditor, type ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { visibleWidth } from "@earendil-works/pi-tui";

/* ------------------------------------------------------------------ *
 * 1. Autocomplete menu ABOVE the input box
 * ------------------------------------------------------------------ */

// `Editor` declares these `private` (TS-only; erased at runtime by jiti). Read
// them through a narrow shape so the access is explicit rather than relying on
// silent erasure across pi versions.
type EditorInternals = {
  autocompleteState: unknown;
  autocompleteList: { render(width: number): string[] } | null | undefined;
  paddingX: number;
};

class AutocompleteAboveEditor extends CustomEditor {
  override render(width: number): string[] {
    const self = this as unknown as EditorInternals;
    if (!self.autocompleteState || !self.autocompleteList) {
      return super.render(width);
    }

    // Render the editor box without the trailing menu by temporarily clearing
    // the active state. `Editor.render()` only consults `autocompleteState` for
    // that one trailing block, so this yields exactly
    // [topBorder, ...contentLines, bottomBorder].
    const savedState = self.autocompleteState;
    self.autocompleteState = null;
    const boxLines = super.render(width);
    self.autocompleteState = savedState;

    // Replicate the padding / content-width math from `Editor.render()`.
    const paddingX = Math.min(
      self.paddingX,
      Math.max(0, Math.floor((width - 1) / 2)),
    );
    const contentWidth = Math.max(1, width - paddingX * 2);
    const pad = " ".repeat(paddingX);

    const menuLines = self.autocompleteList.render(contentWidth).map((line) => {
      const fill = " ".repeat(Math.max(0, contentWidth - visibleWidth(line)));
      return `${pad}${line}${fill}${pad}`;
    });

    return [...menuLines, ...boxLines];
  }
}

/* ------------------------------------------------------------------ *
 * 2. Bottom-anchor the editor + footer
 * ------------------------------------------------------------------ */

type Renderable = { render(width: number): string[] };
// The editor container is both a renderable and a parent: it has `render` and
// `children`. Structurally it satisfies `Renderable`, so it can live in
// `tui.children` and be passed to `renderRange` / `indexOf` directly.
type ContainerLike = { children: Renderable[]; render(width: number): string[] };

const INSTALLED = Symbol("pi.bottomAnchor.installed");
const GET_EDITOR = Symbol("pi.bottomAnchor.getEditor");
const SPLIT_CONTAINER = Symbol("pi.bottomAnchor.splitContainer");

/** Render children[start..end) into a flat string[], mirroring Container.render. */
const renderRange = (
  children: Renderable[],
  start: number,
  end: number,
  width: number,
): string[] => {
  const lines: string[] = [];
  for (let i = start; i < end; i++) {
    const child = children[i];
    if (!child || typeof child.render !== "function") continue;
    for (const line of child.render(width)) lines.push(line);
  }
  return lines;
};

/** Find the direct child of `tui` that currently contains the editor (its
 *  parent container). The editor container is the split point between the top
 *  block and the bottom block. */
const findSplitContainer = (
  tui: ContainerLike,
  editor: unknown,
): ContainerLike | null => {
  for (const child of tui.children) {
    if (
      child &&
      typeof child === "object" &&
      "children" in child &&
      Array.isArray((child as ContainerLike).children)
    ) {
      if ((child as ContainerLike).children.includes(editor as Renderable)) {
        return child as ContainerLike;
      }
    }
  }
  return null;
};

/** Patch `tui.render` (once) to bottom-anchor the editor/footer block. */
function installBottomAnchor(tui: any, getEditor: () => unknown): void {
  // Always refresh the editor getter so editor swaps (new session, another
  // extension re-setting the editor) are picked up by the (already-installed)
  // patched render.
  tui[GET_EDITOR] = getEditor;
  if (tui[INSTALLED]) return;
  tui[INSTALLED] = true;

  const originalRender = tui.render.bind(tui);

  tui.render = (width: number): string[] => {
    const rows: number = tui.terminal?.rows ?? 0;
    const children = tui.children as Renderable[];

    // (Re)discover the split point if missing or removed.
    let split = tui[SPLIT_CONTAINER] as ContainerLike | null | undefined;
    if (!split || !children.includes(split)) {
      const editor = tui[GET_EDITOR]?.();
      split = editor ? findSplitContainer(tui as ContainerLike, editor) : null;
      tui[SPLIT_CONTAINER] = split;
    }

    // Need a valid split with a non-empty top block and a known height.
    if (!rows || !split) return originalRender(width);
    const idx = children.indexOf(split);
    if (idx <= 0) return originalRender(width);

    const top = renderRange(children, 0, idx, width);
    const bottom = renderRange(children, idx, children.length, width);
    const fill = Math.max(0, rows - top.length - bottom.length);
    if (fill === 0) return [...top, ...bottom];

    const blanks = new Array<string>(fill).fill("");
    return [...top, ...blanks, ...bottom];
  };
}

/* ------------------------------------------------------------------ *
 * Entry point
 * ------------------------------------------------------------------ */

export default function (pi: ExtensionAPI): void {
  pi.on("session_start", (_event, ctx) => {
    let currentEditor: AutocompleteAboveEditor | null = null;
    ctx.ui.setEditorComponent((tui: any, theme: any, keybindings: any) => {
      currentEditor = new AutocompleteAboveEditor(tui, theme, keybindings);
      installBottomAnchor(tui, () => currentEditor);
      return currentEditor;
    });
  });
}
