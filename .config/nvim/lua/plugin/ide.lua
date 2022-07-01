------ Language Server Protocol (LSP)
local nvim_lsp = require("lspconfig")
local on_attach = function(_, bufnr)
    -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    local opts = {noremap = true, silent = false}
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>h',
                                '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>",
                                "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>i",
                                "<cmd>lua vim.lsp.buf.implementation()<CR>",
                                opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', "<C-f>o", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>j",
                                "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                                opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>D',
                                '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
                                opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>c', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-f>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable the following language servers
local servers = {"hls", "pyright", "rust_analyzer", "rls", "rnix"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities, -- advertise cmp capabilities
        flags = {debounce_text_changes = 150}
    })
end

------ COMPE completion

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          "n", true)
end

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert
        }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert
        }),
        ["<Esc>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = {
        {name = "nvim_lsp"}, {name = "cmp_tabnine"}, {name = "treesitter"},
        {name = "spell"}, {name = "path"}
    },
    formatting = { -- to show completion source
        format = function(entry, vim_item)
            -- set a name for each source
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                cmp_tabnine = "[Tabnine]",
                treesitter = "[Treesitter]"
            })[entry.source.name]
            return vim_item
        end
    }
})

------ Tabnine

local tabnine = require("cmp_tabnine.config")
tabnine:setup({max_lines = 1000, max_num_results = 10, sort = true})

------ Treesitter

require("nvim-treesitter.configs").setup({
    highlight = {enable = true},
    indent = {enable = true}
})

------ NeoFormatter

vim.g.neoformat_basic_format_align = 1 -- Enable alignment
vim.g.neoformat_basic_format_retab = 1 -- " Enable tab to spaces conversion
vim.g.neoformat_basic_format_trim = 1 -- Enable trimmming of trailing whitespace
vim.g.neoformat_verbose = 0 -- for debugging

-- auto format on save
vim.cmd([[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.js,*.ts, FormatWrite
augroup END
command! Format execute 'lua vim.lsp.buf.formatting()'
]])

------ Surround

require("nvim-surround").setup({
    keymaps = { -- vim-surround style keymaps
        insert = "ys",
        visual = "S",
        delete = "ds",
        change = "cs"
    },
    delimiters = {
        pairs = {
            ["("] = {"( ", " )"},
            [")"] = {"(", ")"},
            ["{"] = {"{ ", " }"},
            ["}"] = {"{", "}"},
            ["<"] = {"< ", " >"},
            [">"] = {"<", ">"},
            ["["] = {"[ ", " ]"},
            ["]"] = {"[", "]"}
        },
        separators = {
            ["'"] = {"'", "'"},
            ['"'] = {'"', '"'},
            ["`"] = {"`", "`"}
        },
        HTML = {
            ["t"] = true -- Use "t" for HTML-style mappings
        },
        aliases = {
            ["a"] = ">", -- Single character aliases apply everywhere
            ["b"] = ")",
            ["B"] = "}",
            ["r"] = "]",
            ["q"] = {'"', "'", "`"} -- Table aliases only apply for changes/deletions
        }
    }
})

