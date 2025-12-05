-- -- copilot auto complete
-- vim.pack.add { { src = "https://github.com/github/copilot.vim" } }
-- vim.keymap.set(
--     "i",
--     "<C-l>",
--     'copilot#Accept("<CR>")',
--     { expr = true, noremap = true, silent = true, replace_keycodes = false, desc = "copilot autocomplete" }
-- )

-- lsp setup
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


-- auto complete
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            convert = function(item)
                -- Only show abbr name, remove leading misc chars (bullets etc.),
                -- and cap field to 15 chars
                local abbr = item.label
                abbr = abbr:gsub("%b()", ""):gsub("%b{}", "")
                abbr = abbr:match("[%w_.]+.*") or abbr
                abbr = #abbr > 15 and abbr:sub(1, 14) .. "…" or abbr
                -- Cap return value field to 15 chars
                local menu = item.detail or ""
                menu = #menu > 15 and menu:sub(1, 14) .. "…" or menu
                return { abbr = abbr, menu = menu }
            end,
        })
    end,
})

-- -- inlay hints
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client and client:supports_method "textDocument/inlayHint" then
--             vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
--         end
--     end,
-- })

--- auto format
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        vim.lsp.buf.format { async = false }
    end,
})


-- treesitter
vim.pack.add { { src = "https://github.com/nvim-treesitter/nvim-treesitter" } }
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    callback = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "diff", "vim", "vimdoc", "query", "bash", "c", "cpp", "lua", "python", "rust", "haskell", "sql", "yaml", "regex", "markdown", "markdown_inline", "ledger" },
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
