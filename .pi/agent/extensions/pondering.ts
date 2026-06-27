/**
 * Pondering
 *
 * Replaces pi's default "Working..." streaming loader message with "Pondering...".
 * Applied on session start so it persists across loader recreations (turns, etc.).
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    ctx.ui.setWorkingMessage("Pondering...");
  });
}
