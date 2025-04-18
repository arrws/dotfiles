return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip", -- required
            "hrsh7th/vim-vsnip", -- required
        },
        opts = function()
            local cmp = require "cmp"
            return {
                snippet = { -- required
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.confirm { select = true },
                    ["<backspace>"] = cmp.mapping.abort(),
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "spell" },
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            buffer = "[BUF]",
                            path = "[PATH]",
                            spell = "[SPELL]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
            }
        end,
    },

    {
        "stevearc/conform.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- runs multiple formatters sequentially
                    -- use a sub-list to run only the first available formatter
                    -- bash = { "a", { "b", "c" } },
                    python = { "ruff_fix", "ruff_format", "yapf" },
                    nix = { "nixfmt" },
                    rust = { "rustfmt" },
                    -- run on all filetypes
                    ["*"] = { "codespell" },
                    -- to on filetypes that don't have other formatters configured
                    ["_"] = { "trim_whitespace" },
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
