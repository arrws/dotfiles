return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local servers = {
                "pyright",
                "rust_analyzer",
                "lua_ls",
                "ruff",
            }
            vim.lsp.enable { servers = servers }

            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lspconfig = require "lspconfig"
            for _, server in ipairs(servers) do
                lspconfig[server].setup {
                    capabilities = capabilities,
                }
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Enable inlay hints",
                callback = function(event)
                    local id = vim.tbl_get(event, "data", "client_id")
                    local client = id and vim.lsp.get_client_by_id(id)
                    if client == nil or not client.supports_method "textDocument/inlayHint" then
                        return
                    end

                    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                end,
            })
        end,
    },

    {
        "Saghen/blink.cmp",
        event = "InsertEnter",
        version = "1.*",
        opts = {
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                -- ["<BS>"] = { "hide", "fallback_to_mappings" },
                ["<TAB>"] = { "select_next", "fallback" },
                ["<S-TAB>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<CR>"] = { "accept", "fallback_to_mappings" },
            },

            cmdline = { enabled = false },
            signature = { enabled = true },

            completion = {
                documentation = { auto_show = false },
                menu = {
                    draw = {
                        columns = { { "label", gap = 1 }, { "kind", gap = 1 }, { "source_name" } },
                    },
                },
            },

            sources = {
                default = { "lsp", "path", "buffer" },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
    },

    {
        "stevearc/conform.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_fix", "ruff_format", "yapf" },
                    nix = { "nixfmt" },
                    rust = { "rustfmt" },
                    ["*"] = { "codespell" }, -- all files
                    ["_"] = { "trim_whitespace" }, -- files with no formatter configured
                },
            }
        end,
        -- command to run async formatting
        init = function()
            vim.api.nvim_create_user_command("Format", function(args)
                local range = nil
                if args.count ~= -1 then
                    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                    range = {
                        start = { args.line1, 0 },
                        ["end"] = { args.line2, end_line:len() },
                    }
                end
                require("conform").format { async = true, lsp_fallback = true, range = range }
            end, { range = true })
        end,
        vim.keymap.set("n", "<leader>p", ":Format<CR>", { desc = "format current buffer" }),
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "python",
                "sql",
                "rust",
                "regex",
                "ledger",
                "bash",
                "yaml",
            },
        },
    },
}
