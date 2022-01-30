local set = vim.opt

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


vim.cmd([[
filetype plugin indent on
]])

set.syntax='on'

set.mouse='a'             -- enable mouse mode

set.hidden = true              -- do not save when swithing buffers -> work with multiple files easier
set.backup = false
set.swapfile = false
set.history=1000        -- status line commands history
set.showcmd = true            -- show in status line the command you're typing
set.laststatus=2        -- status line
set.cmdheight=1         -- height status line
set.wildmenu = true           -- status line menu
set.wildmode='full'
set.wildoptions='tagfile'

set.number = true              -- or relativenumber
set.numberwidth=1       -- number column width
set.ruler  = true              -- show current column in status bar right corner
-- set signcolumn=number	-- merge sign and numbers gutter golumns
--" set signcolumn=yes:1  --" always show sign column
set.signcolumn='auto:1'   -- sign column
set.foldcolumn='0'        -- fold column width
set.fillchars='vert:│'   -- vertical bar delimiter

set.cursorline = true          -- highlight current line
set.showmatch = true           -- show matching braces

set.undofile = true            -- save undo history

set.diffopt:append('vertical')



vim.cmd('colorscheme mscheme')


-- MY BINDINGS

vim.g.mapleader = ";"
vim.cmd('set timeout timeoutlen=1000 ttimeoutlen=10')

-- noremap('<leader>a :source ~/.config/nvim/colors/mscheme.vim<cr>
noremap('<leader>q', ':q!<cr>')
nnoremap('<leader>w', ':w<cr>')
inoremap('<leader>w', '<C-c>:w<cr>')
noremap('\\q', ':q!<cr>')
nnoremap('\\w', ':w<cr>')
inoremap('\\w', '<C-c>:w<cr>')
noremap('<C-q>', ':q!<cr>')
nnoremap('<C-w>', ':w<cr>')
inoremap('<C-w>', '<C-c>:w<cr>')
nnoremap('<space>w', ':w<cr>')
imap('jk', '<esc>')

vim.cmd([[
no J }
no K {
no H ^
no L $
]])

-- Redo with U instead of Ctrl+R
nnoremap('U', '<C-R>')


-- arrow keys to move lines
nnoremap('<up>', 'ddkP')
vnoremap('<up>', ':m \'<-2<CR>gv=gv')
vnoremap('<down>', ':m \'>+1<CR>gv=gv')
nnoremap('<down>', 'ddp')


-- add newline without insert
nmap('go', 'o<ESC>k')
nmap('gO', 'O<ESC>j')

-- spellcheck
map('gz', ':setlocal spell! spelllang=en_us,es<CR>')
map('gZ', ':set nospell<CR>')


-- make vim remember last cursor position
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])




-- make dot work over visual line selections
-- enablea a simple form of dot repetition over visual line selections.
-- only simple operations that start from the beginning of a line be dot repeated.
xnoremap('.', ':norm.<CR>')



-- MOVEMENT

-- disable space so that it won't move cursor
nnoremap('<SPACE>', '<Nop>')

-- disable these
-- map('<C-e>', '<Nop> -- scroll the window downwards one line.
-- map('<C-y>', '<Nop> -- scroll the window upwards one line.
-- map('<C-u>', '<Nop> -- move your cursor upward half a screen.
-- map('<C-d>', '<Nop> -- move your cursordownward half a screen.
map('<C-b>', '<Nop>')  -- moves screen up one page, cursor to last line
map('<C-f>', '<Nop>')  -- moves screen down one page, cursor to first line


-- TABS - don't use tabs
-- nnoremap('<C-\>t', ':tabnew +terminal<CR>')
-- tnoremap('<C-\>t', '<C-\><C-n>:tabnew +terminal<CR>')
-- nnoremap('<C-[> gt')
-- nnoremap('<C-]> gT')
-- nnoremap('<leader>t', ':tabnew<cr>')
-- nnoremap('<leader>1 1gt')
-- nnoremap('<leader>2 2gt')
-- nnoremap('<leader>3 3gt')
-- nnoremap('<leader>4 4gt')
-- nnoremap('<leader>5 5gt')
-- nnoremap('<leader>6 6gt')
-- nnoremap('<leader>7 7gt')
-- nnoremap('<leader>8 8gt')
-- nnoremap('<leader>9 9gt')
-- nnoremap('<leader>0', ':tablast<CR>')



-- WINDOWS

-- automatically equalize splits when resized
vim.cmd('autocmd VimResized * wincmd =')

set.splitbelow = true
set.splitright = true

nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')
nnoremap('<C-h>', '<C-w>h')

nnoremap('<C-s>j', '<C-w>s')
nnoremap('<C-s>l', '<C-w>v')
-- nnoremap('<C-x>', '<C-w>q')

nnoremap('<C-w>r', '<C-w>r')      -- rotate the windows
nnoremap('<C-w>e', '<C-w>x')      -- exchange with next window
nnoremap('<C-w>=', '<C-w>=')      -- reset all windows
nnoremap('<C-w>l', ':vertical resize +5<CR>')
nnoremap('<C-w>h', ':vertical resize -5<CR>')
nnoremap('<C-w>j', ':resize +5<CR>')
nnoremap('<C-w>k', ':resize -5<CR>')



-- BUFFERS

nnoremap('<C-n>', ':bn<CR>')
nnoremap('<C-p>', ':bp<CR>')
nnoremap('<C-x>', ':Bdelete<CR>')
-- noremap('<C-q>', ':bdelete<CR>')






-- SPACING

set.expandtab = true      -- TAB is expanded into spaces
set.shiftwidth=4   -- num space characters for indent
set.tabstop=4      -- num space characters for TAB key
set.softtabstop=4
set.autoindent = true
set.smartindent = true
set.breakindent = true
set.backspace='indent,eol,start' -- change backspace to behave more intuitively
set.backspace='2'
set.linespace=0


-- normal tabbing with TAB key
-- nnoremap('<TAB> >>')
-- nnoremap('<S-TAB>', '<<')
-- vnoremap('<TAB> >gv')
-- vnoremap('<S-TAB>', '<gv')


-- yank until the end of line
nnoremap('Y', 'y$')

-- highlight on yank
vim.cmd([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])



-- SEARCHING

set.hlsearch = true 	    -- highligh matched search terms
set.incsearch = true       -- start searching as you type letters
set.ignorecase = true      -- make searches case sensitive
set.smartcase = true       -- will search case sensitive if uppercase present, needs ignorecase set

noremap('<BS>', ':noh<CR>')   -- clear search highlight

set.inccommand='nosplit' -- live visualization of substitutions



-- TERMINAL

-- Maps ESC to exit terminal's insert mode
vim.cmd([[
if has('nvim')
    tnoremap('<Esc> <C-\><C-n>
    tnoremap('<leader>q  <C-\><C-n>
    tnoremap('<C-m>q  <C-\><C-n>
endif
]])

-- open a new horizontal split with a terminal
nnoremap('<C-t>j', ':new +terminal<CR>')
tnoremap('<C-t>j', '<C-\\><C-n>:new +terminal<CR>')

-- open a new vertical split with a terminal
nnoremap('<C-t>l', ':vnew +terminal<CR>')
tnoremap('<C-t>l', '<C-\\><C-n>:vnew +terminal<cr>')

vim.cmd([[
augroup startup
	autocmd!
	" avoid nesting by adding a buffer to the existing vim session (credit justinmk)
	autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
		\ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
		\ |let g:f=fnameescape(expand('%:p'))
		\ |noau bwipe
		\ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
		\ |call rpcrequest(g:r, "nvim_command", "call lib#SetNumberDisplay()")
		\ |qa
		\ |endif
augroup END

augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
    " remap('Escape to leave terminal mode
    autocmd TermOpen * tnoremap('<buffer> <Esc> <c-\><c-n>
augroup END
]])

-- When in terminal mode, when I change directory (cd), I would like vim to also change its working directory (:cd). You can do so by adding this in your .zshrc or .bashrc:
-- #!/usr/bin/sh
-- function cd() {
--   builtin cd "$@";
--   # if the parent process is nvim, do a vim cd
--   (ps -o comm= $PPID | grep nvim > /dev/null) && vmux-send :cd "$@"
-- }
-- export cd


