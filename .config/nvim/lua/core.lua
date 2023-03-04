vim.cmd([[
filetype plugin indent on
]])

vim.opt.syntax = 'on'
vim.opt.mouse = 'a'           -- enable mouse mode

vim.opt.hidden = true         -- do not save when swithing buffers -> work with multiple files easier
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.history = 1000        -- status line commands history
vim.opt.showcmd = true        -- show in status line the command you're typing
vim.opt.laststatus = 2        -- status line
vim.opt.cmdheight = 1         -- height status line

vim.opt.wildmenu = true       -- status line menu
vim.opt.wildmode = 'full'
vim.opt.wildoptions = 'tagfile'

vim.opt.number = true         -- or relativenumber
vim.opt.numberwidth = 1       -- number column width
vim.opt.ruler = true          -- show current column in status bar right corner
-- set signcolumn=number	  -- merge sign and numbers gutter golumns
-- set signcolumn=yes:1       -- always show sign column
vim.opt.signcolumn = 'auto:1' -- sign column
vim.opt.foldcolumn = '0'      -- fold column width
vim.opt.fillchars = 'vert:│'  -- vertical bar delimiter

vim.opt.cursorline = true     -- highlight current line
vim.opt.showmatch = true      -- show matching braces

vim.opt.undofile = true       -- save undo history

vim.opt.diffopt:append('vertical')

-- when running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster
vim.opt.lazyredraw = true


------ SPACING

vim.opt.expandtab = true               -- TAB is expanded into spaces
vim.opt.shiftwidth = 4                 -- num space characters for indent
vim.opt.tabstop = 4                    -- num space characters for TAB key
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.backspace = 'indent,eol,start' -- change backspace to behave more intuitively
vim.opt.backspace = '2'
vim.opt.linespace = 0


------ MY BINDINGS

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.g.colors_name = 'xtheme'
vim.cmd('colorscheme xtheme')


-- leader
nnoremap(';', '<Nop>')
vim.g.mapleader = ";"
vim.cmd('set timeout timeoutlen=1000 ttimeoutlen=10')


noremap('<leader>q', ':q!<cr>')
nnoremap('<leader>w', ':w<cr>')
inoremap('<leader>w', '<C-c>:w<cr>')
noremap('<C-q>', ':q!<cr>')
nnoremap('<C-w>', ':w<cr>')
inoremap('<C-w>', '<C-c>:w<cr>')

imap('jk', '<esc>')

noremap('J', '}')
noremap('K', '{')



-- redo with U instead of Ctrl+R
nnoremap('U', '<C-R>')
nnoremap('<C-R>', 'Nup')


-- add newline without insert
nmap('go', 'o<ESC>k', { desc = 'Put empty line above' })
nmap('gO', 'O<ESC>j', { desc = 'Put empty line below' })

-- Copy/paste with system clipboard
nmap('gy', '"+y', { desc = 'Copy to system clipboard' })
nmap('gp', '"+p', { desc = 'Paste from system clipboard' })

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

-- yank until the end of line
nnoremap('Y', 'y$')

-- highlight on yank
vim.cmd([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])



------ MOVEMENT

-- disable space so that it won't move cursor
nnoremap('<SPACE>', '<Nop>')

-- disable these
map('<C-e>', '<Nop>') -- scroll the window downwards one line.
map('<C-y>', '<Nop>') -- scroll the window upwards one line.
map('<C-b>', '<Nop>') -- moves screen up one page, cursor to last line
map('<C-f>', '<Nop>') -- moves screen down one page, cursor to first line


------ WINDOWS

-- automatically equalize splits when resized
vim.cmd('autocmd VimResized * wincmd =')

vim.opt.splitbelow = true
vim.opt.splitright = true

nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')
nnoremap('<C-h>', '<C-w>h')

nnoremap('<leader>j', '<C-w>s')
nnoremap('<leader>l', '<C-w>v')
nnoremap('<leader>x', '<C-w>q')
nnoremap('<leader>r', '<C-w>x')      -- exchange current with left window
nnoremap('<leader>=', '<C-w>=')      -- reset all windows
nnoremap('<leader>L', ':vertical resize +5<CR>')
nnoremap('<leader>H', ':vertical resize -5<CR>')
nnoremap('<leader>J', ':resize +5<CR>')
nnoremap('<leader>K', ':resize -5<CR>')


------ BUFFERS

nnoremap('<C-n>', ':bn<CR>')
nnoremap('<C-p>', ':bp<CR>')
-- noremap('<C-x>', ':bdelete<CR>')
nnoremap('<C-x>', ':lua MiniBufremove.delete()<CR>')


------ SEARCHING

vim.opt.hlsearch = true     -- highligh matched search terms
vim.opt.incsearch = true    -- start searching as you type letters
vim.opt.ignorecase = true   -- make searches case sensitive
vim.opt.smartcase = true    -- will search case sensitive if uppercase present, needs ignorecase set

noremap('<BS>', ':noh<CR>') -- clear search highlight
vim.opt.inccommand = 'nosplit' -- live visualization of substitutions

-- Search inside visual selection. `silent = false` makes effect immediately.
xmap('g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
xmap('*', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
xmap('#', [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])


------ TERMINAL

-- Maps ESC to exit terminal's insert mode
vim.cmd([[
if has('nvim')
    tnoremap  <Esc> <C-\><C-n>
    tnoremap  <leader>q <C-\><C-n>
endif
]])

-- open a new horizontal split with a terminal
nnoremap('<leader>T', ':new +terminal<CR>')
tnoremap('<leader>T', '<C-\\><C-n>:new +terminal<CR>')

-- open a new vertical split with a terminal
nnoremap('<leader>t', ':vnew +terminal<CR>')
tnoremap('<leader>t', '<C-\\><C-n>:vnew +terminal<cr>')

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

