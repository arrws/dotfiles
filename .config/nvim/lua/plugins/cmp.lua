return {
    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip", -- requiered
            "hrsh7th/vim-vsnip",
        },
        opts = function()
            local cmp = require "cmp"
            local defaults = require "cmp.config.default"()

            return {
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<CR>"] = cmp.mapping.confirm { select = true },
                    ["<C-j>"] = cmp.mapping.confirm { select = true },
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<leader>q"] = cmp.mapping.abort(),
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "buffer" },
                    -- {name = "path"},
                    { name = "spell" },
                },
                formatting = { -- to show completion source
                    format = function(entry, vim_item)
                        -- set a name for each source
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            buffer = "[BUF]",
                            -- path = "[PATH]",
                            spell = "[SPELL]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },

                sorting = defaults.sorting,
            }
        end,

        ---@param opts cmp.ConfigSchema
        config = function(_, opts)
            for _, source in ipairs(opts.sources) do
                source.group_index = source.group_index or 1
            end
            require("cmp").setup(opts)
        end,
    },
}
