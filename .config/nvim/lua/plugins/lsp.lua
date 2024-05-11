return {

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
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

    {
        "lvimuser/lsp-inlayhints.nvim",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = "LspAttach_inlayhints",
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("lsp-inlayhints").on_attach(client, bufnr)
                end,
            })
        end,

        opts = {
            inlay_hints = {
                parameter_hints = {
                    show = false,
                    prefix = "« ",
                    separator = ", ",
                    remove_colon_start = false,
                    remove_colon_end = true,
                },
                type_hints = {
                    -- type and other hints
                    show = true,
                    prefix = "» ",
                    separator = ", ",
                    remove_colon_start = false,
                    remove_colon_end = false,
                },
                only_current_line = false,
                highlight = "InlayHints",
                priority = 0,
            },
            enabled_at_startup = true,
            debug_mode = false,
        },
    },
}
