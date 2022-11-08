------ Git Signs
require("gitsigns").setup({
    signs = {
        add = {hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
        change = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn"
        },
        delete = {
            hl = "GitSignsDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn"
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn"
        },
        changedelete = {
            hl = "GitSignsChange",
            text = "-",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn"
        }
    },
    numhl = false, --- highlight num column text
    linehl = false,
    keymaps = {
        noremap = true,
        buffer = true,
        ["n <C-g>n"] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
        },
        ["n <C-g>p"] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
        },
        ["n <C-g>o"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <C-g>u"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <C-g>U"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ["n <C-g>b"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
        ["n <C-g>s"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <C-g>S"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>'
    },
    watch_gitdir = {interval = 1000},
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil -- Use default
})
