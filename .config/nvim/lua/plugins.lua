
require("colorizer").setup()

--- HOP
require("hop").setup({}) -- keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
nmap('s', ':HopChar1<CR>')
nmap('S', ':HopChar2<CR>')
-- nmap('x', ':HopPattern<CR>')
-- nmap('s', ':HopWord<CR>')
-- nmap('F', ':HopLine<CR>')

-------- LuaLine
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "mtheme",
		component_separators = { "|", "|" },
		section_separators = { "", "" }, -- {'', ''},
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { { "mode", upper = true } },
		lualine_b = { { "branch", icon = "b" } },
		lualine_c = { { "filename", file_status = true } },
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
	extensions = { "fzf" },
})

--------  Language Server Protocol (LSP)
require("lspfuzzy").setup({})
local nvim_lsp = require("lspconfig")
local on_attach = function(_, bufnr)
	-- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = false }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', "<leader>o", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>z', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>c', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
local servers = { "hls", "pylsp", "rls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
	    capabilities = capabilities, -- advertise cmp capabilities
		flags = {
			debounce_text_changes = 150,
		},
	})
end



--------  Treesitter

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})


--------  Git Signs

require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "-", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	numhl = false, --- highlight num column text
	linehl = false,
	keymaps = {
		noremap = true,
		buffer = true,
		["n <leader>n"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
		["n <leader>N"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
		["n <leader>e"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>u"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["n <leader>U"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		["n <leader>b"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
		["n <leader>w"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["n <leader>q"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	},
	watch_gitdir = {
		interval = 1000,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
})

-------- NeoFormatter
-- auto format on save
vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts, FormatWrite
augroup END

command! Format execute 'lua vim.lsp.buf.formatting()'
]])

-------- COMPE completion

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

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Esc>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "cmp_tabnine" },
		{ name = "treesitter" },
		{ name = "spell" },
		{ name = "path" },
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
	},
})

local tabnine = require("cmp_tabnine.config")
tabnine:setup({
	max_lines = 1000,
	max_num_results = 10,
	sort = true,
})


-- Easy Align
-- Start interactive EasyAlign in visual mode (e.g. vipga)
xmap('ga', '<Plug>(EasyAlign)')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap('ga', '<Plug>(EasyAlign)')



-- better whitespace
vim.g.better_whitespace_ctermcolor='darkgray'
vim.g.better_whitespace_enabled=1
vim.g.strip_whitespace_on_save=0


-------- auto pairs
-- require('nvim-autopairs').setup()
require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
	-- disable_filetype = { "TelescopePrompt" , "vim" },
	--- default values
	-- local disable_filetype = { "TelescopePrompt" }
	-- local ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
	-- local enable_moveright = true
	-- local enable_afterquote = true  -- add bracket pairs after quote
	-- local enable_check_bracket_line = true  --- check bracket in same line
	-- local check_ts = false
})

------ indent guides
require("indent_blankline").setup({
	char = "|",
	buftype_exclude = { "terminal", "help", "NvimTree" },
})

-------- Tree View
nnoremap('<C-m>', ':NvimTreeToggle<CR>')

vim.g.nvim_tree_show_icons = {
    git= 0,
    folders= 1,
    files= 0,
}

vim.g.nvim_tree_icons = {
    default='',
    symlink='~',
    git={
      unstaged="×",
      staged="➜",
      unmerged="",
      renamed="",
      untracked=""
      },
    folder={
      default="◼",
      open="┌",
      empty="-",
      empty_open="-",
      symlink="~",
      }
    }

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	update_to_buf_dir = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = "left",
		auto_resize = false,
		mappings = {
			custom_only = false,
			list = {
                { key = "<CR>",          action = "edit" },
                { key = "o",             action = "edit" },
                { key = "<C-CR>",        action = "cd" },
                { key = "<C-BS>",        action = "dir_up" },
                { key = "<C-s>l",        action = "vsplit" },
                { key = "<C-s>j",        action = "split" },
                -- { key = "<C-t>",         action = "tabnew" },
                { key = "<BS>",          action = "close_node" },
                { key = "z",             action = "toggle_ignored" },
                { key = ".",             action = "toggle_dotfiles" },
                { key = "R",             action = "refresh" },
                { key = "c",             action = "create" },
                { key = "D",             action = "remove" },
                { key = "r",             action = "rename" },
                { key = "d",             action = "cut" },
                { key = "y",             action = "copy" },
                { key = "p",             action = "paste" },
                { key = "q",             action = "close" },
		    },
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})


-- FZF fuzzy finder
-- vim.cmd([[
-- command! -bang -nargs=* Rg
--   \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

-- command! -bang -nargs=? -complete=dir HFiles
--   \ call fzf#vim#files(<q-args>, {'source': 'rg --files'}, <bang>0)
-- ]])

-- nmap('<C-r>', ':HFiles<CR>')
-- -- nmap('<C-R>', ':Files<CR>')
-- nmap('<C-f>', ':Rg<CR>')
-- nmap('<C-b>', ':Buffers<CR>')
-- -- nmap('<C-m>', ':Marks<CR>')
-- -- nmap('<C-c>', ':Commits<CR>')


-- -- CTRL-A CTRL-Q to select all and build quickfix list
-- vim.cmd([[
-- function! s:build_quickfix_list(lines)
--   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
--   copen
--   cc
-- endfunction
-- ]])

-- let g:fzf_action = {
--     \ 'ctrl-l': function('s:build_quickfix_list'),
--     \ 'ctrl-s': 'vsplit' }

-- let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

-- -- let g:fzf_layout = { 'down': '~30%' }
-- -- let g:fzf_preview_window = []
-- let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'highlight': 'Comment' } }
-- let g:fzf_preview_window = ['right:50%', 'ctrl-/']

-- vim.cmd([[
-- autocmd! FileType fzf set laststatus=0 noshowmode noruler
--   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
-- ]])

-- let g:fzf_history_dir = '~/.local/share/fzf-history'
-- let g:fzf_buffers_jump = 1 -- [Buffers] Jump to the existing window if possible

-- -- make fzf obey your colorscheme
-- let g:fzf_colors = {
--     \ 'fg':      ['fg', 'Normal'],
--     \ 'bg':      ['bg', 'Normal'],
--     \ 'hl':      ['fg', 'Comment'],
--     \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
--     \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
--     \ 'hl+':     ['fg', 'Statement'],
--     \ 'info':    ['fg', 'PreProc'],
--     \ 'border':  ['fg', 'Ignore'],
--     \ 'prompt':  ['fg', 'Conditional'],
--     \ 'pointer': ['fg', 'Exception'],
--     \ 'marker':  ['fg', 'Keyword'],
--     \ 'spinner': ['fg', 'Label'],
--     \ 'header':  ['fg', 'Comment'] }



-- Fugitive
-- augroup FugitiveMappings
--   autocmd!
--   autocmd FileType fugitive nmap('o fugitive_gO
-- augroup
-- nmap('o fugitive_o
-- fugitive git bindings
-- nnoremap('<space>ga', ':Git add %:p<CR><CR>
-- nnoremap('gs', ':Gstatus<CR>
-- nnoremap('gd', ':Gdiff<CR>
-- nnoremap('<space>gc', ':Gcommit -v -q<CR>
-- nnoremap('<space>gt', ':Gcommit -v -q %:p<CR>
-- nnoremap('<space>ge', ':Gedit<CR>
-- nnoremap('<space>gr', ':Gread<CR>
-- nnoremap('<space>gw', ':Gwrite<CR><CR>
-- nnoremap('<space>gl', ':silent! Glog<CR>:bot copen<CR>
-- nnoremap('<space>gp', ':Ggrep<Space>
-- nnoremap('<space>gm', ':Gmove<Space>
-- nnoremap('<space>gb', ':Git branch<Space>
-- nnoremap('<space>go', ':Git checkout<Space>
-- nnoremap('<space>gps', ':Dispatch! git push<CR>
-- nnoremap('<space>gpl', ':Dispatch! git pull<CR>

