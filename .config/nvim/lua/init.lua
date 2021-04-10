
require("lualine").setup()

require'lspconfig'.tsserver.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.hls.setup{}
require'lspconfig'.pyls.setup{}

require('lspfuzzy').setup {}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
    ["<CR>"]           = tree_cb("edit"),
    ["o"]              = tree_cb("edit"),
    -- ["<2-LeftMouse>"]  = tree_cb("edit"),
    -- ["<2-RightMouse>"] = tree_cb("cd"),
    -- ["<Tab>"]          = tree_cb("preview"),
    ["<leader>o"]      = tree_cb("cd"),
    ["<leader>O"]      = tree_cb("dir_up"),
    ["<leader>s"]      = tree_cb("vsplit"),
    ["<leader>S"]      = tree_cb("split"),
    ["<C-t>"]          = tree_cb("tabnew"),
    ["<BS>"]           = tree_cb("close_node"),
    ["z"]              = tree_cb("toggle_ignored"),
    ["."]              = tree_cb("toggle_dotfiles"),
    ["R"]              = tree_cb("refresh"),
    ["c"]              = tree_cb("create"),
    ["D"]              = tree_cb("remove"),
    ["r"]              = tree_cb("rename"),
    -- ["<C-r>"]          = tree_cb("full_rename"),
    ["d"]              = tree_cb("cut"),
    ["y"]              = tree_cb("copy"),
    ["p"]              = tree_cb("paste"),
    ["]c"]             = tree_cb("prev_git_item"),
    ["[c"]             = tree_cb("next_git_item"),
    ["q"]              = tree_cb("close"),
}

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '-', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    numhl = false,
    linehl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        ['n ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n ghb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

        -- -- Text objects
        -- ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        -- ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
    watch_index = {
        interval = 1000
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,     -- Use default
    use_decoration_api = true,
    use_internal_diff = true,   -- If luajit is present
}


