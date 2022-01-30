
vim.cmd([[
filetype plugin indent on
]])

vim.opt.syntax='on'

vim.opt.mouse='a'             -- enable mouse mode

vim.opt.hidden = true              -- do not save when swithing buffers -> work with multiple files easier
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.history=1000        -- status line commands history
vim.opt.showcmd = true            -- show in status line the command you're typing
vim.opt.laststatus=2        -- status line
vim.opt.cmdheight=1         -- height status line
vim.opt.wildmenu = true           -- status line menu
vim.opt.wildmode='full'
vim.opt.wildoptions='tagfile'

vim.opt.number = true              -- or relativenumber
vim.opt.numberwidth=1       -- number column width
vim.opt.ruler  = true              -- show current column in status bar right corner
-- set signcolumn=number	-- merge sign and numbers gutter golumns
--" set signcolumn=yes:1  --" always show sign column
vim.opt.signcolumn='auto:1'   -- sign column
vim.opt.foldcolumn='0'        -- fold column width
vim.opt.fillchars='vert:│'   -- vertical bar delimiter

vim.opt.cursorline = true          -- highlight current line
vim.opt.showmatch = true           -- show matching braces

vim.opt.undofile = true            -- save undo history

vim.opt.diffopt:append('vertical')



--- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster
vim.opt.lazyredraw = true
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
]])
-- no H ^
-- no L $

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

vim.opt.splitbelow = true
vim.opt.splitright = true

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

vim.opt.expandtab = true      -- TAB is expanded into spaces
vim.opt.shiftwidth=4   -- num space characters for indent
vim.opt.tabstop=4      -- num space characters for TAB key
vim.opt.softtabstop=4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.backspace='indent,eol,start' -- change backspace to behave more intuitively
vim.opt.backspace='2'
vim.opt.linespace=0


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

vim.opt.hlsearch = true 	    -- highligh matched search terms
vim.opt.incsearch = true       -- start searching as you type letters
vim.opt.ignorecase = true      -- make searches case sensitive
vim.opt.smartcase = true       -- will search case sensitive if uppercase present, needs ignorecase set

noremap('<BS>', ':noh<CR>')   -- clear search highlight

vim.opt.inccommand='nosplit' -- live visualization of substitutions



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


