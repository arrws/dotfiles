vim.pack.add {
    { src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
}

-- LSP Configuration
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function()
        local servers = { "pyright", "rust_analyzer", "hls", "lua_ls", "ruff" }

        local lspconfig = require "lspconfig"
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        for _, server in ipairs(servers) do
            lspconfig[server].setup { capabilities = capabilities }
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

-- Blink.cmp
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

-- Conform formatter
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
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format { async = true, lsp_fallback = true, range = range }
end, { range = true })

vim.keymap.set({ "n", "v" }, "<leader>p", function()
    require("conform").format {
        async = true,
        lsp_fallback = true,
    }
end, { desc = "Format buffer" })

-- Treesitter
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
