
-- require('neogit').setup{}

require("colorizer").setup()

--- HOP
require'hop'.setup{} -- keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }


--------  ToggleMouse

-- disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end
-- vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })



-------- LuaLine

require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'mtheme',
    component_separators = {'|', '|'},
    section_separators = {'', ''}, -- {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {{'mode', upper = true}},
    lualine_b = {{'branch', icon = 'b'}},
    lualine_c = {{'filename', file_status = true}},
    lualine_x = {'encoding', 'fileformat', 'filetype', 'progress'},
    lualine_y = {'location'},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fzf'}
}



--------  Language Server Protocol (LSP)

local nvim_lsp = require('lspconfig')
local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)


-- call :DocumentSymbols to show all the symbols in the current buffer
-- call :WorkspaceSymbols to show all the symbols in the workspace, you can optionally pass the query as argument to the command
-- call :IncomingCalls to show the incoming calls
-- call :OutgoingCalls to show the outgoing calls
-- call :CodeActions to show the list of available code actions
-- call :RangeCodeActions to show the list of available code actions in the visual selection



local nvim_lsp = require('lspconfig')
end

-- Enable the following language servers
require'lspconfig'.tsserver.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.hls.setup{}
-- require'lspconfig'.pyls.setup{}

local servers = { 'hls', 'gopls', 'tsserver' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end


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



-------- Tree View

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
    -- ["]c"]             = tree_cb("prev_git_item"),
    -- ["[c"]             = tree_cb("next_git_item"),
    ["q"]              = tree_cb("close"),
}



--------  Git Signs

require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '-', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    numhl = false, --- highlight num column text
    linehl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n [c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
        ['n ]c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

        ['n ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n ghb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
        ['n ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',

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
    use_internal_diff = true,   -- If luajit is present
}



-------- COMPE completion

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    -- path = true;
    -- buffer = true;
    -- calc = true;
    -- nvim_lua = true;
    -- nvim_lsp = true;
    -- tabnine = true;
    -- treesiter = true;
    -- tabnine = {
    --     max_line = 1000;
    --     max_num_results = 6;
    --     priority = 5000;
    --     sort = v:false; -- false means compe will leave tabnine to sort the completion items
    --     show_prediction_strength = v:true;
    --     ignore_pattern = '';
    -- };
  };
}

-- highlight link CompeDocumentation NormalFloat

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})



-------- Formatter

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettier
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
            stdin = true
          }
        end
    },
  }
})


-------- auto pairs
-- require('nvim-autopairs').setup()
require('nvim-autopairs').setup({
  enable_check_bracket_line = false
  -- disable_filetype = { "TelescopePrompt" , "vim" },
  --- default values
  -- local disable_filetype = { "TelescopePrompt" }
-- local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
-- local enable_moveright = true
-- local enable_afterquote = true  -- add bracket pairs after quote
-- local enable_check_bracket_line = true  --- check bracket in same line
-- local check_ts = false
})

require('indent_guides').setup({
    indent_levels = 20;
    indent_guide_size = 1;
    indent_start_level = 1;
    indent_enable = true;
    indent_space_guides = true;
    indent_tab_guides = false;
    indent_soft_pattern = '\\s';
    exclude_filetypes = {'help','dashboard','dashpreview','NvimTree','vista','sagahover'};
    even_colors = { fg ='#2a3834',bg='#000000' };
    odd_colors = {fg='#332b36',bg='#000000'};
})

