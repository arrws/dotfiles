-- -- Copilot Complete
-- vim.pack.add { { src = "https://github.com/github/copilot.vim" } }
-- vim.keymap.set(
--     "i",
--     "<C-l>",
--     'copilot#Accept("<CR>")',
--     { expr = true, noremap = true, silent = true, replace_keycodes = false, desc = "copilot autocomplete" }
-- )

-- Blink.cmp
vim.pack.add { { src = "https://github.com/Saghen/blink.cmp" } }
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        require("blink.cmp").setup {
            keymap = {
                preset = "none",
                ["<TAB>"] = { "select_next", "fallback" }, -- C-n
                ["<S-TAB>"] = { "select_prev", "fallback" }, -- C-p
            },
            cmdline = { enabled = false },
            completion = {
                menu = {
                    draw = {
                        columns = { { "label", gap = 1 }, { "kind", gap = 1 }, { "source_name" } },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "buffer" },
            },
        }
    end,
    once = true,
})

-- LSP
vim.pack.add { { src = "https://github.com/neovim/nvim-lspconfig" } }
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function()
        local servers = {
            pyright = {},
            ruff = {},
            rust_analyzer = {},
            lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
            hls = {},
        }

        -- Base capabilities from blink.cmp
        local base_capabilities = require("blink.cmp").get_lsp_capabilities()

        -- Add semantic token support
        base_capabilities.textDocument.semanticTokens = {
            dynamicRegistration = false,
            requests = { full = { delta = true } },
            tokenTypes = {
                "namespace",
                "type",
                "class",
                "enum",
                "interface",
                "struct",
                "typeParameter",
                "parameter",
                "variable",
                "property",
                "enumMember",
                "event",
                "function",
                "method",
                "macro",
                "keyword",
                "modifier",
                "comment",
                "string",
                "number",
                "regexp",
                "operator",
                "decorator",
            },
            tokenModifiers = {
                "declaration",
                "definition",
                "readonly",
                "static",
                "deprecated",
                "abstract",
                "async",
                "modification",
                "documentation",
                "defaultLibrary",
            },
        }

        for server, config in pairs(servers) do
            config.capabilities = base_capabilities
            vim.lsp.config(server, config)
            -- vim.lsp.enable(server)
        end
    end,
    once = true,
})
-- inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method "textDocument/inlayHint" then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

-- Conform formatter
vim.pack.add { { src = "https://github.com/stevearc/conform.nvim" } }
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function()
        require("conform").setup {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_fix", "ruff_format" },
                nix = { "nixfmt" },
                rust = { "rustfmt" },
                ["_"] = { "trim_whitespace" },
            },
        }
    end,
    once = true,
})
vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = { start = { args.line1, 0 }, ["end"] = { args.line2, end_line:len() } }
    end
    require("conform").format { async = true, lsp_fallback = true, range = range }
end, { range = true })

-- Treesitter
vim.pack.add { { src = "https://github.com/nvim-treesitter/nvim-treesitter" } }
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = {
                "diff",
                "vim",
                "vimdoc",
                "query",
                "bash",
                "c",
                "cpp",
                "lua",
                "python",
                "rust",
                "haskell",
                "sql",
                "yaml",
                "regex",
                "markdown",
                "markdown_inline",
                "ledger",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        }
    end,
    once = true,
})
