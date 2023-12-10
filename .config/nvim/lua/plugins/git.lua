return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },

        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "-" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "|" },
            },

            signcolumn = true,
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                follow_files = true,
            },

            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 1000,
                ignore_whitespace = false,
            },

            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,

            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Navigation
                vim.keymap.set("n", "<C-f>n",   gs.next_hunk,       { buffer = bufnr, desc = "next hunk" })
                vim.keymap.set("n", "<C-f>N",   gs.prev_hunk,       { buffer = bufnr, desc = "prev hunk" })

                -- Actions
                vim.keymap.set("n", "<C-f>hp",  gs.preview_hunk,    { buffer = bufnr, desc = "preview hunk" })
                vim.keymap.set("n", "<C-f>o",   gs.stage_hunk,      { buffer = bufnr, desc = "stage hunk" })
                vim.keymap.set("n", "<C-f>O",   gs.undo_stage_hunk, { buffer = bufnr, desc = "undo stage hunk" })
                vim.keymap.set("n", "<C-f>hb",  gs.stage_buffer,    { buffer = bufnr, desc = "stage buffer" })
                vim.keymap.set("n", "<C-f>u",   gs.reset_hunk,      { buffer = bufnr, desc = "reset hunk" })

                vim.keymap.set("n", "<C-f>hb", function()
                    gs.blame_line { full = true }
                end, { buffer = bufnr, desc = "blame line" })

                vim.keymap.set("n", "<C-f>hd", gs.diffthis)
                vim.keymap.set("n", "<C-f>hD", function()
                    gs.diffthis "~"
                end, { buffer = bufnr, desc = "diffthis" })
            end,
        },
    },
}
