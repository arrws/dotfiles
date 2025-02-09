return {
    {
        "hat0uma/csvview.nvim",
        config = function()
            require("csvview").setup()
        end,
    },

    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require("colortils").setup {
                register = "*", -- register
                default_format = "hex", -- hex, hsl or rgb
                color_preview = "████ %s",
                border = "single",
                mappings = {
                    increment = "l",
                    decrement = "h",
                    increment_big = "L",
                    decrement_big = "H",
                    min_value = "0",
                    max_value = "$",
                    set_register_default_format = "g<cr>",
                    -- set_register_choose_format = "g<cr>",
                    replace_default_format = "<cr>",
                    -- replace_choose_format = "g<m-cr>",
                    quit_window = { "q", "<esc>" },
                },
            }
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup {
                "*",
                lua = { mode = "foreground" },
            }
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = (require "xtheme.line"),
                component_separators = { "|", "|" },
                section_separators = { "", "" },
                disabled_filetypes = {},
            },
            sections = {
                lualine_a = { { "mode", upper = true } },
                lualine_b = { { "branch", icon = "b" } },
                lualine_c = { { "filename", file_status = true, path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype", "progress" },
                lualine_y = { "location" },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {},
        },
    },
}
