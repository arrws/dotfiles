vim.opt.shell = "/run/current-system/sw/bin/zsh"
-- vim.opt.shell = "/bin/bash" -- for speed in case of using other shells

-- bootstrap function
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
    })
end
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim' -- requiered

    -- fzf
    use 'nvim-telescope/telescope-live-grep-args.nvim' -- requiered
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

    --- LSP
    use 'neovim/nvim-lspconfig'
    use 'sbdchd/neoformat'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use({ -- nicer diagnostics text
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    })

    -- autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip' -- requiered
    use 'hrsh7th/vim-vsnip'
    use {'tzachar/cmp-tabnine', run = './install.sh'}

    
    use 'simrat39/rust-tools.nvim'
    -- use 'mfussenegger/nvim-dap'                 -- debugging

    -- others
    use 'hoob3rt/lualine.nvim'
    use 'kyazdani42/nvim-tree.lua'

    use 'lewis6991/gitsigns.nvim'               -- git line status on the vertical bar
    use 'lukas-reineke/indent-blankline.nvim'   -- display thin vertical lines at each indentation level

    use 'echasnovski/mini.jump'                 --  better f/t jumping
    use 'echasnovski/mini.bufremove'            -- close buffers without closing windows
    use 'echasnovski/mini.comment'              -- bindings to comment stuff out
    use 'echasnovski/mini.align'                -- alligning text
    use 'echasnovski/mini.pairs'                -- auto-complete parenthesis
    use 'echasnovski/mini.trailspace'           -- for trailling whitespace
    use 'echasnovski/mini.surround'             -- change surrounding elements

    use 'norcalli/nvim-colorizer.lua'           -- highlight colors
    use 'ledger/vim-ledger'

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then require('packer').sync() end
end)

-- Helpers
function nnoremap(shortcut, command) vim.api.nvim_set_keymap('n', shortcut, command, {noremap = true, silent = true}) end
function vnoremap(shortcut, command) vim.api.nvim_set_keymap('v', shortcut, command, {noremap = true, silent = true}) end
function inoremap(shortcut, command) vim.api.nvim_set_keymap('i', shortcut, command, {noremap = true, silent = true}) end
function xnoremap(shortcut, command) vim.api.nvim_set_keymap('x', shortcut, command, {noremap = true, silent = true}) end
function tnoremap(shortcut, command) vim.api.nvim_set_keymap('t', shortcut, command, {noremap = true, silent = true}) end
function noremap(shortcut, command) vim.api.nvim_set_keymap('', shortcut, command, {noremap = true, silent = true}) end
function imap(shortcut, command) vim.api.nvim_set_keymap('i', shortcut, command, {noremap = false, silent = true}) end
function nmap(shortcut, command) vim.api.nvim_set_keymap('n', shortcut, command, {noremap = false, silent = true}) end
function xmap(shortcut, command) vim.api.nvim_set_keymap('x', shortcut, command, {noremap = false, silent = true}) end
function map(shortcut, command) vim.api.nvim_set_keymap('', shortcut, command, {noremap = false, silent = true}) end

-- disable some builtin vim plugins
local disabled_built_ins = {
    "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
    "getscript", "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin", "logipat", "rrhelper",
    "spellfile_plugin", "matchit"
}
for _, plugin in pairs(disabled_built_ins) do vim.g["loaded_" .. plugin] = 1 end

require('core')


require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.trailspace').setup()
require('mini.align').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.jump').setup({
    mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = '',
        backward_till = '',
        repeat_jump = ''
    }
})

require("indent_blankline").setup({
    char = "│",
    buftype_exclude = {"terminal", "help", "NvimTree"}
})

require("colorizer").setup()

require('plugin.line')
require('plugin.tree')
require('plugin.fzf')
require('plugin.ide')
require('plugin.git')

