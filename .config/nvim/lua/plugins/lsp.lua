set_n = function(cmd, action, desc, bufnr)
    vim.keymap.set("n", cmd, action, { noremap = true, silent = false, bufnr=bufnr, desc = desc })
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            -- add borders to floating windows
            local border = {
                { "┌", "FloatBorder" },
                { "─", "FloatBorder" },
                { "┐", "FloatBorder" },
                { "│", "FloatBorder" },
                { "┘", "FloatBorder" },
                { "─", "FloatBorder" },
                { "└", "FloatBorder" },
                { "│", "FloatBorder" },
            }
            local handlers = { -- LSP settings (for overriding per client)
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
            }

            local on_attach = function(client, bufnr)
                -- set_n("<C-f> ', vim.lsp.buf.implementation, "go to implementation", bufnr)
                -- set_n("<C-f> ", vim.lsp.buf.declaration, "go to declaration", bufnr)
                set_n("<C-k>", vim.lsp.buf.definition, "go to definition", bufnr)
                set_n("<C-f>h", vim.lsp.buf.hover, "hover info", bufnr)
                set_n("<C-f>R", vim.lsp.buf.rename, "rename", bufnr)
                set_n("<C-f>a", vim.lsp.buf.code_action, "line diagnostics", bufnr)
                set_n("<C-f>d", "<cmd>lua vim.diagnostic.open_float(nil, { border='rounded', source=false })<CR>", "line diagnostics", bufnr)
            end

            -- nvim-cmp supports additional completion capabilities
            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            -- Enable the following language servers
            local nvim_lsp = require "lspconfig"
            local servers = { "pyright", "rust_analyzer" }
            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities, -- advertise cmp capabilities
                    handlers = handlers,
                }
            end
        end,
    },
}
