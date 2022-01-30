vim.opt.shell = "/bin/bash" -- for speed in case of using other shells

-- bootstrap function
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'hoob3rt/lualine.nvim' -- lua statusline
    use 'kyazdani42/nvim-tree.lua' -- file explorer
    use 'phaazon/hop.nvim' -- better easy-motion

    -- FZF
    use {'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'}
    use {'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'}

    -- IDE stuff
    use 'neovim/nvim-lspconfig' -- LSP help installing servers
    use {'nvim-treesitter/nvim-treesitter', -- LSP based syntax highlighting
        run = ':TSUpdate'}
    use {'lewis6991/gitsigns.nvim', -- git signs for vertical bar
        requires = 'nvim-lua/plenary.nvim'}
    -- use 'gfanto/fzf-lsp.nvim'                                  -- use FZF for  displaying LSP searches
    -- use { 'ojroques/nvim-lspfuzzy', tag= 'v0.1.0' }          -- integrate FZF with the LSP server

    -- autocomplete
    use 'hrsh7th/nvim-cmp' -- LSP autocomplete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'ray-x/cmp-treesitter'
    use 'L3MON4D3/LuaSnip' -- requiered Snippets plugin
    -- use {'tzachar/cmp-tabnine', run = './install.sh'} -- ML autocomplete

    -- utils
    use 'tpope/vim-repeat' -- enable . repeat for plugins
    use 'bronson/vim-visual-star-search' -- visual select with *
    use 'famiu/bufdelete.nvim' -- close buffers without closing windows with :Bdelete
    use 'norcalli/nvim-colorizer.lua' -- highlight colors

    -- text
    use 'junegunn/vim-easy-align' -- alligning text
    use 'lukas-reineke/indent-blankline.nvim' -- display thin vertical lines at each indentation level
    use 'blackCauldron7/surround.nvim' -- smart bindings to change surrounding elements
    use 'windwp/nvim-autopairs' -- auto-complete parenthesis and other brackets
    use 'terrortylor/nvim-comment'  -- bindings to comment stuff out
    use 'ntpeters/vim-better-whitespace' -- for trailling whitespace


    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)


-- Helpers
set = vim.opt
function nnoremap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap= true, silent = true })
end
function vnoremap(shortcut, command)
  vim.api.nvim_set_keymap('v', shortcut, command, { noremap= true, silent = true })
end
function inoremap(shortcut, command)
  vim.api.nvim_set_keymap('i', shortcut, command, { noremap= true, silent = true })
end
function xnoremap(shortcut, command)
  vim.api.nvim_set_keymap('x', shortcut, command, { noremap= true, silent = true })
end
function tnoremap(shortcut, command)
  vim.api.nvim_set_keymap('t', shortcut, command, { noremap= true, silent = true })
end
function noremap(shortcut, command)
  vim.api.nvim_set_keymap('', shortcut, command, { noremap= true, silent = true })
end
function imap(shortcut, command)
  vim.api.nvim_set_keymap('i', shortcut, command, { noremap= false, silent = true })
end
function nmap(shortcut, command)
  vim.api.nvim_set_keymap('n', shortcut, command, { noremap= false, silent = true })
end
function xmap(shortcut, command)
  vim.api.nvim_set_keymap('x', shortcut, command, { noremap= false, silent = true })
end
function map(shortcut, command)
  vim.api.nvim_set_keymap('', shortcut, command, { noremap= false, silent = true })
end


-- disable some builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end


require('core')
-- require('misc')
-- require('fzf')
-- require('ide')
-- require('tree')
-- require('text')

