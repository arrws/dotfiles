-- -- Copilot Complete
-- vim.pack.add { { src = "https://github.com/github/copilot.vim" } }
-- vim.keymap.set(
--     "i",
--     "<C-l>",
--     'copilot#Accept("<CR>")',
--     { expr = true, noremap = true, silent = true, replace_keycodes = false, desc = "copilot autocomplete" }
-- )

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

        for server, config in pairs(servers) do
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
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
                python = { "ruff_fix", "ruff_format" },
                lua = { "stylua" },
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
