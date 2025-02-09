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
                -- vim.keymap.set('n', '<C-f> ', vim.lsp.buf.implementation, { noremap=true, silent=false, buffer=bufnr, desc= "go to implementation"  })
                -- vim.keymap.set('n', '<C-f> ', vim.lsp.buf.declaration, { noremap=true, silent=false, buffer=bufnr, desc= "go to declaration"  })
                vim.keymap.set(
                    "n",
                    "<C-k>",
                    vim.lsp.buf.definition,
                    { noremap = true, silent = false, buffer = bufnr, desc = "go to definition" }
                )
                vim.keymap.set(
                    "n",
                    "<C-f>h",
                    vim.lsp.buf.hover,
                    { noremap = true, silent = false, buffer = bufnr, desc = "hover info" }
                )
                vim.keymap.set(
                    "n",
                    "<C-f>R",
                    vim.lsp.buf.rename,
                    { noremap = true, silent = false, buffer = bufnr, desc = "rename" }
                )
                vim.keymap.set(
                    "n",
                    "<C-f>a",
                    vim.lsp.buf.code_action,
                    { noremap = true, silent = false, buffer = bufnr, desc = "line diagnostics" }
                )
                vim.keymap.set(
                    "n",
                    "<C-f>d",
                    "<cmd>lua vim.diagnostic.open_float(nil, { border='rounded', source=false })<CR>",
                    { noremap = true, silent = false, buffer = bufnr, desc = "line diagnostics" }
                )
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
