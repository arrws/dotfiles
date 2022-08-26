------ HOP
require("hop").setup({}) -- keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
nmap('s', ':HopChar1<CR>')
nmap('S', ':HopChar2<CR>')
-- nmap('x', ':HopPattern<CR>')
-- nmap('s', ':HopWord<CR>')
-- nmap('F', ':HopLine<CR>')

-- Colorizer
require("colorizer").setup()

------ Easy Align
xmap('ga', '<Plug>(EasyAlign)') -- Start interactive EasyAlign in visual mode (e.g. vipga)
nmap('ga', '<Plug>(EasyAlign)') -- Start interactive EasyAlign for a motion/text object (e.g. gaip)

-- Comment Out
require('nvim_comment').setup {
    marker_padding = true, -- Linters prefer comment and line to have a space in between markers
    comment_empty = true, -- should comment out empty or whitespace only lines
    create_mappings = true, -- Should key mappings be created
    line_mapping = "gcc", -- Normal mode mapping left hand side
    operator_mapping = "gc", -- Visual/Operator mapping left hand side
    hook = nil -- Hook function to call before commenting takes place
}

-- Better Whitespace
vim.g.better_whitespace_ctermcolor = 'darkgray'
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 0

-- Auto Pairs
require("nvim-autopairs").setup({
    disable_filetype = {"TelescopePrompt"},
    disable_in_macro = true, -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    enable_moveright = true,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true, -- check bracket in same line
    check_ts = false,
    map_bs = true, -- map the <BS> key
    map_c_h = false, -- Map the <C-h> key to delete a pair
    map_c_w = false -- map <c-w> to delete a pair if possible
})

-- Indent Lines
require("indent_blankline").setup({char = "│", buftype_exclude = {"terminal", "help", "NvimTree"}})
