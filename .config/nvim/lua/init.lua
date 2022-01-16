-- require('neogit').setup{}

require("colorizer").setup()

--- HOP
require("hop").setup({}) -- keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

--------  ToggleMouse

-- disable mouse mode and indentlines for easier paste
ToggleMouse = function()
	if vim.o.mouse == "a" then
		vim.cmd([[IndentBlanklineDisable]])
		vim.wo.signcolumn = "no"
		vim.o.mouse = "v"
		vim.wo.number = false
		print("Mouse disabled")
	else
		vim.cmd([[IndentBlanklineEnable]])
		vim.wo.signcolumn = "yes"
		vim.o.mouse = "a"
		vim.wo.number = true
		print("Mouse enabled")
	end
end
-- vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

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

local nvim_lsp = require("lspconfig")

local on_attach = function(_, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gj", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- call :DocumentSymbols to show all the symbols in the current buffer
	-- call :WorkspaceSymbols to show all the symbols in the workspace, you can optionally pass the query as argument to the command
	-- call :IncomingCalls to show the incoming calls
	-- call :OutgoingCalls to show the outgoing calls
	-- call :CodeActions to show the list of available code actions
	-- call :RangeCodeActions to show the list of available code actions in the visual selection
end

-- Enable the following language servers
local servers = { "hls", "pylsp", "rls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

require("lspfuzzy").setup({})

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
		-- Default keymap options
		noremap = true,
		buffer = true,

		["n [c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
		["n ]c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

		["n ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["n ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		["n ghb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
		["n ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["n ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',

		-- -- Text objects
		-- ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
		-- ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
	},
	watch_index = {
		interval = 1000,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
})

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

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
-- require'lspconfig'.tsserver.setup{
--   capabilities = capabilities, -- advertise cmp capabilities
-- }
-- require'lspconfig'.gopls.setup{
--   capabilities = capabilities, -- advertise cmp capabilities
-- }
require("lspconfig").hls.setup({
	capabilities = capabilities, -- advertise cmp capabilities
})
require("lspconfig").pylsp.setup({
	capabilities = capabilities, -- advertise cmp capabilities
})
require("lspconfig").rls.setup({
	capabilities = capabilities, -- advertise cmp capabilities
})

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
			list = {},
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

-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- vim.g.nvim_tree_bindings = {
--     { key = "<CR>",          cb = tree_cb("edit") },
--     { key = "o",             cb = tree_cb("edit") },
--     { key = "<C-Cr>",     cb = tree_cb("cd") },
--     { key = "<C-BS>",     cb = tree_cb("dir_up") },
--     { key = "<C-m>s",     cb = tree_cb("vsplit") },
--     { key = "<C-m>S",     cb = tree_cb("split") },
--     -- { key = "<C-t>",         cb = tree_cb("tabnew") },
--     { key = "<BS>",          cb = tree_cb("close_node") },
--     { key = "z",             cb = tree_cb("toggle_ignored") },
--     { key = ".",             cb = tree_cb("toggle_dotfiles") },
--     { key = "R",             cb = tree_cb("refresh") },
--     { key = "c",             cb = tree_cb("create") },
--     { key = "D",             cb = tree_cb("remove") },
--     { key = "r",             cb = tree_cb("rename") },
--     { key = "d",             cb = tree_cb("cut") },
--     { key = "y",             cb = tree_cb("copy") },
--     { key = "p",             cb = tree_cb("paste") },
--     { key = "q",             cb = tree_cb("close") },
-- }
