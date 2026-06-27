/**
 * Web Access
 *
 * Gives the agent the ability to browse the web by registering two tools:
 *
 *   - web_fetch:  fetch a URL and return its content as readable text
 *   - web_search: find web pages by keywords (DuckDuckGo, best-effort)
 *
 * Both tools are abort-aware (they honor the tool execution signal) and
 * cap output size to avoid blowing up the context window.
 *
 * Auto-discovered globally from ~/.pi/agent/extensions/. Use /reload to
 * pick up edits without restarting pi.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";

const DEFAULT_USER_AGENT =
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 " +
  "(KHTML, like Gecko) Chrome/124.0 Safari/537.36";

// ---------------------------------------------------------------------------
// HTML utilities
// ---------------------------------------------------------------------------

const ENTITIES: Record<string, string> = {
  amp: "&",
  lt: "<",
  gt: ">",
  quot: '"',
  apos: "'",
  nbsp: " ",
  "#39": "'",
};

function decodeEntities(s: string): string {
  return s.replace(/&(#x?[0-9a-fA-F]+|[a-zA-Z]+);/g, (full, ent: string) => {
    if (ent.startsWith("#x") || ent.startsWith("#X")) {
      const code = parseInt(ent.slice(2), 16);
      return Number.isNaN(code) ? full : String.fromCodePoint(code);
    }
    if (ent.startsWith("#")) {
      const code = parseInt(ent.slice(1), 10);
      return Number.isNaN(code) ? full : String.fromCodePoint(code);
    }
    return ENTITIES[ent] ?? full;
  });
}

/** Strip all HTML tags from a fragment (no whitespace normalization). */
function stripTags(html: string): string {
  return decodeEntities(html.replace(/<[^>]+>/g, ""));
}

/**
 * Convert an HTML document to readable plain text:
 * - drop script/style/noscript/template/svg
 * - turn block-level elements into line breaks
 * - strip remaining tags and decode entities
 * - collapse whitespace
 */
function htmlToText(html: string): string {
  let s = html;
  s = s.replace(
    /<(script|style|noscript|template|svg|head|iframe)\b[\s\S]*?<\/\1>/gi,
    " ",
  );
  // Block-level boundaries -> newlines
  s = s.replace(/<\/(p|div|li|ul|ol|tr|td|th|section|article|header|footer|h[1-6]|pre|blockquote|br)>/gi, "\n");
  s = s.replace(/<br\s*\/?>/gi, "\n");
  // Strip remaining tags
  s = s.replace(/<[^>]+>/g, " ");
  s = decodeEntities(s);
  // Normalize whitespace
  s = s.replace(/[ \t\f\v]+/g, " ");
  s = s.replace(/\n[ \t]+/g, "\n");
  s = s.replace(/\n{3,}/g, "\n\n");
  return s.trim();
}

/** Truncate text to a max length, noting truncation. */
function truncate(text: string, maxChars: number): { text: string; truncated: boolean } {
  if (text.length <= maxChars) return { text, truncated: false };
  return { text: text.slice(0, maxChars), truncated: true };
}

interface DdgResult {
  title: string;
  url: string;
  snippet: string;
}

/** Extract organic results from DuckDuckGo's HTML endpoint. */
function extractDdgResults(html: string): DdgResult[] {
  const links: { title: string; url: string }[] = [];
  const linkRe = /<a[^>]*class="[^"]*result__a[^"]*"[^>]*href="([^"]+)"[^>]*>([\s\S]*?)<\/a>/gi;
  let m: RegExpExecArray | null;
  while ((m = linkRe.exec(html)) !== null) {
    const uddg = m[1].match(/uddg=([^&]+)/);
    if (!uddg) continue;
    let url = "";
    try {
      url = decodeURIComponent(uddg[1]);
    } catch {
      continue;
    }
    const title = stripTags(m[2]).trim();
    if (!url || !title) continue;
    links.push({ title, url });
  }

  const snippets: string[] = [];
  const snipRe = /<a[^>]*class="[^"]*result__snippet[^"]*"[^>]*>([\s\S]*?)<\/a>/gi;
  while ((m = snipRe.exec(html)) !== null) {
    snippets.push(stripTags(m[1]).trim());
  }

  return links.slice(0, 10).map((l, i) => ({ ...l, snippet: snippets[i] ?? "" }));
}

// ---------------------------------------------------------------------------
// Extension
// ---------------------------------------------------------------------------

export default function (pi: ExtensionAPI) {
  // --- web_fetch -----------------------------------------------------------
  pi.registerTool({
    name: "web_fetch",
    label: "Web Fetch",
    description:
      "Fetch a URL over HTTP(S) and return its content as readable text. " +
      "HTML pages are converted to plain text; other content is returned raw. " +
      "Use this to read web pages or fetch live data.",
    promptSnippet: "Fetch a URL and return its text content",
    promptGuidelines: [
      "Use web_fetch to read a web page or fetch live information from the internet when the answer is not already known.",
    ],
    parameters: Type.Object({
      url: Type.String({ description: "Absolute http(s) URL to fetch." }),
      maxChars: Type.Optional(
        Type.Number({
          description: "Maximum characters of content to return. Default 20000.",
        }),
      ),
    }),
    async execute(_toolCallId, params, signal) {
      const url = String(params.url ?? "").trim();
      const maxChars = Number(params.maxChars) > 0 ? Number(params.maxChars) : 20000;

      if (!/^https?:\/\//i.test(url)) {
        return {
          content: [{ type: "text", text: `Invalid URL (must start with http:// or https://): ${url}` }],
          isError: true,
          details: { url, error: "invalid url" },
        };
      }

      try {
        const res = await fetch(url, {
          signal,
          redirect: "follow",
          headers: {
            "User-Agent": DEFAULT_USER_AGENT,
            Accept: "text/html,application/xhtml+xml,application/json,text/plain,*/*;q=0.8",
          },
        });
        const contentType = res.headers.get("content-type") ?? "";
        const raw = await res.text();

        const isHtml = /text\/html|application\/xhtml/i.test(contentType) || /^\s*<!doctype html|<html/i.test(raw);
        const body = isHtml ? htmlToText(raw) : raw;
        const { text, truncated } = truncate(body, maxChars);

        const header = `URL: ${url}\nStatus: ${res.status} ${res.statusText}\nContent-Type: ${contentType || "unknown"}${truncated ? `\n(truncated to ${maxChars} chars; full length ${body.length})` : ""}\n\n`;

        return {
          content: [{ type: "text", text: header + text }],
          details: { url, status: res.status, contentType, truncated, length: body.length },
        };
      } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        return {
          content: [{ type: "text", text: `Error fetching ${url}: ${message}` }],
          isError: true,
          details: { url, error: message },
        };
      }
    },
  });

  // --- web_search ----------------------------------------------------------
  pi.registerTool({
    name: "web_search",
    label: "Web Search",
    description:
      "Search the web via DuckDuckGo and return up to 10 results " +
      "(title, URL, snippet). Use this to discover relevant pages, then " +
      "call web_fetch to read the ones you need. Best-effort: may return " +
      "fewer results if the search engine throttles the request.",
    promptSnippet: "Search the web (DuckDuckGo) for pages by keywords",
    promptGuidelines: [
      "Use web_search when you need to find current information but do not know the exact URL, then use web_fetch to read the most relevant result.",
    ],
    parameters: Type.Object({
      query: Type.String({ description: "Search query." }),
      maxResults: Type.Optional(
        Type.Number({ description: "Maximum number of results to return. Default 8." }),
      ),
    }),
    async execute(_toolCallId, params, signal) {
      const query = String(params.query ?? "").trim();
      const maxResults = Number(params.maxResults) > 0 ? Number(params.maxResults) : 8;

      if (!query) {
        return {
          content: [{ type: "text", text: "Empty search query." }],
          isError: true,
          details: { error: "empty query" },
        };
      }

      const searchUrl = `https://html.duckduckgo.com/html/?q=${encodeURIComponent(query)}`;

      try {
        const res = await fetch(searchUrl, {
          signal,
          redirect: "follow",
          headers: {
            "User-Agent": DEFAULT_USER_AGENT,
            Accept: "text/html,application/xhtml+xml,*/*;q=0.8",
          },
        });
        const html = await res.text();
        let results = extractDdgResults(html).slice(0, maxResults);

        if (results.length === 0) {
          return {
            content: [
              {
                type: "text",
                text: `No results extracted for "${query}" (status ${res.status}). The search engine may have throttled the request; try again or refine the query.`,
              },
            ],
            details: { query, status: res.status, count: 0 },
          };
        }

        const lines = results.map(
          (r, i) =>
            `${i + 1}. ${r.title}\n   ${r.url}${r.snippet ? `\n   ${r.snippet}` : ""}`,
        );

        return {
          content: [
            {
              type: "text",
              text: `Search: "${query}" (${results.length} results)\n\n${lines.join("\n\n")}`,
            },
          ],
          details: { query, status: res.status, count: results.length, results },
        };
      } catch (err) {
        const message = err instanceof Error ? err.message : String(err);
        return {
          content: [{ type: "text", text: `Error searching for "${query}": ${message}` }],
          isError: true,
          details: { query, error: message },
        };
      }
    },
  });
}
