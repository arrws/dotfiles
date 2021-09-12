
-- require('neogit').setup{}

require("colorizer").setup()

--- HOP
require'hop'.setup{} -- keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

--- Which Key
require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

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

require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{
      capabilities = capabilities, -- advertise capabilities for nvim_cmp
  }
  nvim_lsp[server].setup { on_attach = on_attach }
end


--[[
-- Enable the following language servers
require'lspconfig'.tsserver.setup{
  capabilities = capabilities, -- advertise cmp capabilities
}
require'lspconfig'.gopls.setup{
  capabilities = capabilities, -- advertise cmp capabilities
}
require'lspconfig'.hls.setup{
  capabilities = capabilities, -- advertise cmp capabilities
}
-- require'lspconfig'.pyls.setup{
--   capabilities = capabilities, -- advertise cmp capabilities
-- }

local servers = { 'hls', 'gopls', 'tsserver' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end
 ]]

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
    { key = "<CR>",          cb = tree_cb("edit") },
    { key = "o",             cb = tree_cb("edit") },
    { key = "<leader>o",     cb = tree_cb("cd") },
    { key = "<leader>O",     cb = tree_cb("dir_up") },
    { key = "<leader>s",     cb = tree_cb("vsplit") },
    { key = "<leader>S",     cb = tree_cb("split") },
    { key = "<C-t>",         cb = tree_cb("tabnew") },
    { key = "<BS>",          cb = tree_cb("close_node") },
    { key = "z",             cb = tree_cb("toggle_ignored") },
    { key = ".",             cb = tree_cb("toggle_dotfiles") },
    { key = "R",             cb = tree_cb("refresh") },
    { key = "c",             cb = tree_cb("create") },
    { key = "D",             cb = tree_cb("remove") },
    { key = "r",             cb = tree_cb("rename") },
    { key = "d",             cb = tree_cb("cut") },
    { key = "y",             cb = tree_cb("copy") },
    { key = "p",             cb = tree_cb("paste") },
    { key = "q",             cb = tree_cb("close") },
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

-- nvim-cmp setup
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

-- local lspkind = require('lspkind')
local luasnip = require("luasnip")
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- ['<Tab>'] = cmp.mapping.select_next_item(),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    -- ['<CR>'] = cmp.mapping.confirm {
      -- behavior = cmp.ConfirmBehavior.Replace,
      -- select = true,
    -- },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        feedkey("<C-n>")
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        feedkey("<C-p>")
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'cmp_tabnine' },
    { name = 'treesitter' },
    { name = 'spell' },
    { name = 'path' },
  },
  formatting = { -- to show completion source
    format = function(entry, vim_item)
    -- set a name for each source
    vim_item.menu = ({
      nvim_lsp = "[LSP]",
      cmp_tabnine = "[Tabnine]",
      treesitter = "[Treesitter]",
    })[entry.source.name]
    return vim_item
  end,
  }
}

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
        max_lines = 1000;
        max_num_results = 10;
        sort = true;
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


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

