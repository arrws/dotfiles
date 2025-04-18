return {
    {
        "echasnovski/mini.diff", -- :lua MiniDiff.toggle_overlay()
        event = { "BufReadPre", "BufNewFile" },
        version = false,
        config = function()
            require("mini.diff").setup {
                view = {
                    style = "sign", -- "number"
                    signs = { add = "+", change = ">", delete = "-" },
                },
            }
        end,
    },

    {
        "echasnovski/mini.bufremove",
        config = function()
            require("mini.bufremove").setup {}
        end,
    },

    {
        "echasnovski/mini.pairs",
        config = function()
            require("mini.pairs").setup {}
        end,
    },

    {
        "echasnovski/mini.align",
        config = function()
            require("mini.align").setup {}
        end,
    },

    {
        "echasnovski/mini.surround",
        config = function()
            require("mini.surround").setup { n_lines = 200 }
        end,
    },

    {
        "echasnovski/mini.jump",
        config = function()
            require("mini.jump").setup {}
        end,
    },

    {
        "echasnovski/mini.jump2d",
        config = function()
            require("mini.jump2d").setup {}
        end,
    },

    {
        "echasnovski/mini.move",
        opts = {
            mappings = {
                -- Move visual selection. Defaults are Alt (Meta) + hjkl.
                left = "<left>",
                right = "<right>",
                down = "<down>",
                up = "<up>",

                -- Move current line
                line_left = "<left>",
                line_right = "<right>",
                line_down = "<down>",
                line_up = "<up>",
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
                highlight = { "IndentBlanklineChar" },
            },
            whitespace = {
                remove_blankline_trail = true,
                highlight = { "IndentBlanklineSpaceChar" },
            },
            scope = {
                enabled = false,
                char = "│",
                show_start = false,
                show_end = false,
                highlight = { "IndentBlanklineContextChar" },
            },
            exclude = {
                filetypes = {
                    "FTerm",
                    "Terminal",
                    "help",
                    "packer",
                    "NvimTree",
                    "conf",
                    "alpha",
                },
            },
        },
    },
}
