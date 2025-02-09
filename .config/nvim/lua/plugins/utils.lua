return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "▎",
                tab_char = "▎",
                highlight = { "IndentBlanklineChar" },
            },
            whitespace = {
                remove_blankline_trail = true,
                highlight = { "IndentBlanklineSpaceChar" },
            },
            scope = {
                enabled = false,
                char = "▎",
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

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        config = function()
            require("marks").setup {
                -- whether to map keybinds or not. default true
                default_mappings = false,
                -- which builtin marks to show. default {}
                builtin_marks = { ".", "<", ">", "^" },
                -- whether movements cycle back to the beginning/end of buffer. default true
                cyclic = true,
                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = false,
                -- how often (in ms) to redraw signs/recompute mark positions.
                -- higher values will have better performance but may cause visual lag,
                -- while lower values may cause performance penalties. default 150.
                refresh_interval = 250,
                mappings = {},
            }
        end,
    },
}
