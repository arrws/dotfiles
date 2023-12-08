return {

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
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

    { "echasnovski/mini.bufremove" },

    { "echasnovski/mini.trailspace" },

    { "echasnovski/mini.pairs" },

    {
        "echasnovski/mini.comment",
        opts = {
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both Normal and Visual modes
                comment = "gc",
                -- Toggle comment on current line
                comment_line = "gcc",
                -- Toggle comment on visual selection
                comment_visual = "gc",
                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                textobject = "gc",
            },
        },
    },

    { "echasnovski/mini.align" },

    {
        "echasnovski/mini.surround",
        opts = {
            highlight_duration = 500,

            mappings = {
                add = "sa", -- Add surrounding in Normal and Visual modes
                delete = "sd", -- Delete surrounding
                find = "sf", -- Find surrounding (to the right)
                find_left = "sF", -- Find surrounding (to the left)
                highlight = "sh", -- Highlight surrounding
                replace = "sr", -- Replace surrounding
                update_n_lines = "sn", -- Update `n_lines`

                suffix_last = "l", -- Suffix to search with "prev" method
                suffix_next = "n", -- Suffix to search with "next" method
            },

            -- Number of lines within which surrounding is searched
            n_lines = 20,

            -- Whether to respect selection type: linewise, blockwise
            respect_selection_type = false,
        },
    },

    {
        "echasnovski/mini.jump",
        opts = {
            mappings = {
                forward = "f",
                backward = "F",
                forward_till = "",
                backward_till = "",
                repeat_jump = "",
            },
        },
    },

    {
        "echasnovski/mini.jump2d",
        opts = {
            -- Characters used for labels of jump spots (in supplied order)
            labels = "abcdefghijklmnopqrstuvwxyz",
            -- Which lines are used for computing spots
            allowed_lines = {
                blank = true, -- Blank line (not sent to spotter even if `true`)
                cursor_before = true, -- Lines before cursor line
                cursor_at = true, -- Cursor line
                cursor_after = true, -- Lines after cursor line
                fold = true, -- Start of fold (not sent to spotter even if `true`)
            },
            -- Which windows from current tabpage are used for visible lines
            allowed_windows = {
                current = true,
                not_current = true,
            },
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                start_jumping = "t",
            },
        },
    },

    {
        "echasnovski/mini.move",
        opts = {
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = "<left>",
                right = "<right>",
                down = "<down>",
                up = "<up>",

                -- Move current line in Normal mode
                line_left = "<left>",
                line_right = "<right>",
                line_down = "<down>",
                line_up = "<up>",
            },
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        },
    },
}
