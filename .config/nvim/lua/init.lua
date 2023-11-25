-- bootstrap function
local fn = vim.fn

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not vim.loop.fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add{
    'nvim-lua/plenary.nvim'; -- requiered
    'folke/which-key.nvim';

    -- fzf
    'nvim-telescope/telescope-live-grep-args.nvim'; -- requiered
    'nvim-telescope/telescope-ui-select.nvim';
    'nvim-telescope/telescope.nvim';
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' };

    --- LSP
    'neovim/nvim-lspconfig';
    'sbdchd/neoformat';
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'};
    'lvimuser/lsp-inlayhints.nvim';

    -- -- autocomplete
    'hrsh7th/nvim-cmp';
    'hrsh7th/cmp-nvim-lsp';
    'hrsh7th/cmp-buffer';
    'hrsh7th/cmp-path';
    'hrsh7th/cmp-vsnip'; -- requiered
    'hrsh7th/vim-vsnip';

    -- 'Exafunction/codeium.vim'
    -- 'github/copilot.vim'
    
    -- gui
    'hoob3rt/lualine.nvim';
    'kyazdani42/nvim-tree.lua';              -- sidebar file explorer
    'lewis6991/gitsigns.nvim';               -- git line status on the vertical bar
    'lukas-reineke/indent-blankline.nvim';   -- display thin vertical lines at each indentation level

    -- core 
    'echasnovski/mini.jump';                 -- better f/t jumping
    'echasnovski/mini.jump2d';               -- easy motion like hopping
    'echasnovski/mini.map';                  -- vscode like minimap
    'echasnovski/mini.bufremove';            -- close buffers without closing windows
    'echasnovski/mini.comment';              -- bindings to comment stuff out
    'echasnovski/mini.move';                 -- arrow keys to move visual selection or current line
    'echasnovski/mini.align';                -- alligning text
    'echasnovski/mini.pairs';                -- auto-complete parenthesis
    'echasnovski/mini.trailspace';           -- for trailling whitespace
    'echasnovski/mini.surround';             -- change surrounding elements

    -- theme
    'rktjmp/lush.nvim';
    '~/.config/nvim/lua/lush_theme';
}

require("which-key").setup()
require("which-key").register(mappings, opts)

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
require('plugin.line')
require('plugin.tree')
require('plugin.ide')
require('plugin.lsp')
require('plugin.git')
require('plugin.fzf')

