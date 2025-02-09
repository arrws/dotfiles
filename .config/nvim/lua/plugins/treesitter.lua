return {
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
}
