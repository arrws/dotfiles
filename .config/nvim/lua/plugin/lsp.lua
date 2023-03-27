------ Language Server Protocol (LSP)

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=false, buffer=bufnr }
    -- vim.keymap.set('n', '<C-f> ', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-f> ', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<C-f>h', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-f>R', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<C-f>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<C-f>d', '<cmd>lua vim.diagnostic.open_float(nil, { border=\'rounded\', source=false })<CR>', bufopts)
end


------ Lsp Config

-- add borders to flaoting windows
local border = {
      {"┌", "FloatBorder"},
      {"─", "FloatBorder"},
      {"┐", "FloatBorder"},
      {"│", "FloatBorder"},
      {"┘", "FloatBorder"},
      {"─", "FloatBorder"},
      {"└", "FloatBorder"},
      {"│", "FloatBorder"},
}
local handlers =  { -- LSP settings (for overriding per client)
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local nvim_lsp = require("lspconfig")
local servers = {"pyright", "rust_analyzer"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities, -- advertise cmp capabilities
        handlers = handlers,
    })
end


------ Inlay Hints
require("lsp-inlayhints").setup({
  inlay_hints = {
    parameter_hints = {
      show = false,
      prefix = "« ",
      separator = ", ",
      remove_colon_start = false,
      remove_colon_end = true,
    },
    type_hints = {
      -- type and other hints
      show = true,
      prefix = "» ",
      separator = ", ",
      remove_colon_start = false,
      remove_colon_end = false,
    },
    only_current_line = false,
    highlight = "InlayHints",
    priority = 0,
  },
  enabled_at_startup = true,
  debug_mode = false,
})

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})


------ CMP completion
vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}

local cmp = require("cmp")
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ['<C-j>'] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<leader>q'] = cmp.mapping.abort(),
    },
    sources = cmp.config.sources({
        {name = "cmp_tabnine"}, {name = "nvim_lsp"}, {name = "vsnip"},
        {name = "buffer"}, {name = "spell"}, {name = "path"}
    }),
    formatting = { -- to show completion source
        format = function(entry, vim_item)
            -- set a name for each source
            vim_item.menu = ({
                cmp_tabnine = "[TAB]",
                nvim_lsp = "[LSP]",
                buffer = "[BUF]",
                path = "[PATH]"
            })[entry.source.name]
            return vim_item
        end
    }
})



------  Github Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

------  Tabnine
tabnine = require("cmp_tabnine.config")
tabnine:setup({max_lines = 100, max_num_results = 5, sort = true})


------ Treesitter
require("nvim-treesitter.configs").setup({
    highlight = {enable = true},
    indent = {enable = true}
})


------ NeoFormatter
vim.g.neoformat_basic_format_align = 1  -- enable alignment
vim.g.neoformat_basic_format_retab = 1  -- enable tab to spaces conversion
vim.g.neoformat_basic_format_trim = 1   -- enable trimmming of trailing whitespace
vim.g.neoformat_verbose = 0             -- for debugging
