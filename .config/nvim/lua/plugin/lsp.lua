------ Language Server Protocol (LSP)

local nvim_lsp = require("lspconfig")
local on_attach = function(_, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local opts = {noremap = true, silent = false}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', "<C-f>I", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>H", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>R', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Enable the following language servers
local servers = {"hls", "pyright", "rust_analyzer", "rnix"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities, -- advertise cmp capabilities
        flags = {debounce_text_changes = 150}
    })
end


------ Diagnostics

vim.diagnostic.config({
    virtual_lines = true,   -- fancy hints
    -- virtual_lines = { only_current_line = true },
    virtual_text = false,   -- inline hints
})
require("lsp_lines").setup()

------ Rust tools

local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    inlay_hints = {
        -- automatically set inlay hints (type hints)
        auto = true,
        -- Only show inlay hints for the current line
        only_current_line = false,
    },
})
rt.inlay_hints.enable()


------ CMP completion
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require("cmp")
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args) vim.fn["vsnip#anonymous"](args.body) end
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
        ['<leader>q'] = cmp.mapping.abort(),
        ['<Esc>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({
        {name = "cmp_tabnine"}, {name = "nvim_lsp"}, {name = "vsnip"},
        {name = "buffer"}, {name = "spell"}, {name = "path"}
    }),
    formatting = { -- to show completion source
        format = function(entry, vim_item)
            -- set a name for each source
            vim_item.menu = ({
                cmp_tabnine = "[AI]",
                nvim_lsp = "[LSP]",
                buffer = "[BUF]",
                path = "[PATH]"
            })[entry.source.name]
            return vim_item
        end
    }
})


------  Tabnine
local tabnine = require("cmp_tabnine.config")
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

-- auto format on save
vim.cmd([[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.js,*.ts, FormatWrite
    augroup END
    command! Format execute 'lua vim.lsp.buf.formatting()'
]])

