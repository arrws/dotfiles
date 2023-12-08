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

noremap = { noremap = true }



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


-- leader
vim.keymap.set('n', ';', '<Nop>', noremap)
vim.g.mapleader = ";"
vim.cmd('set timeout timeoutlen=1000 ttimeoutlen=10')


vim.keymap.set('', '<leader>q', ':q!<cr>', noremap)
vim.keymap.set('n', '<leader>w', ':w<cr>', noremap)
vim.keymap.set('i', '<leader>w', '<C-c>:w<cr>', noremap)
vim.keymap.set('', '<C-q>', ':q!<cr>', noremap)
vim.keymap.set('n', '<C-w>', ':w<cr>', noremap)
vim.keymap.set('i', '<C-w>', '<C-c>:w<cr>', noremap)

vim.keymap.set('i', 'jk', '<esc>')

vim.keymap.set('', 'J', '}', noremap)
vim.keymap.set('', 'K', '{', noremap)


-- redo with U instead of Ctrl+R
vim.keymap.set('n', 'U', '<C-R>', noremap)
vim.keymap.set('n', '<C-R>', 'Nup', noremap)


-- add newline without insert
vim.keymap.set('n', 'go', 'o<ESC>k', { desc = 'Put empty line above' })
vim.keymap.set('n', 'gO', 'O<ESC>j', { desc = 'Put empty line below' })

-- Copy/paste with system clipboard
vim.keymap.set('n', 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })

-- make vim remember last cursor position
vim.cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
]])

-- make dot work over visual line selections
-- enablea a simple form of dot repetition over visual line selections.
-- only simple operations that start from the beginning of a line be dot repeated.
vim.keymap.set('x', '.', ':norm.<CR>', noremap)

-- yank until the end of line
vim.keymap.set('n', 'Y', 'y$', noremap)

-- highlight on yank
vim.cmd([[
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]])



------ MOVEMENT

-- disable space so that it won't move cursor
vim.keymap.set('n', '<SPACE>', '<Nop>', noremap)

-- disable these
vim.keymap.set('', '<C-e>', '<Nop>') -- scroll the window downwards one line.
vim.keymap.set('', '<C-y>', '<Nop>') -- scroll the window upwards one line.
vim.keymap.set('', '<C-b>', '<Nop>') -- moves screen up one page, cursor to last line
vim.keymap.set('', '<C-f>', '<Nop>') -- moves screen down one page, cursor to first line


------ WINDOWS

-- automatically equalize splits when resized
vim.cmd('autocmd VimResized * wincmd =')

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.keymap.set('n', '<C-j>', '<C-w>j', noremap)
vim.keymap.set('n', '<C-k>', '<C-w>k', noremap)
vim.keymap.set('n', '<C-l>', '<C-w>l', noremap)
vim.keymap.set('n', '<C-h>', '<C-w>h', noremap)

vim.keymap.set('n', '<leader>j', '<C-w>s', noremap)
vim.keymap.set('n', '<leader>l', '<C-w>v', noremap)
vim.keymap.set('n', '<leader>x', '<C-w>q', noremap)
vim.keymap.set('n', '<leader>r', '<C-w>x', noremap)      -- exchange current with left window
vim.keymap.set('n', '<leader>=', '<C-w>=', noremap)      -- reset all windows
vim.keymap.set('n', '<leader>L', ':vertical resize +5<CR>', noremap)
vim.keymap.set('n', '<leader>H', ':vertical resize -5<CR>', noremap)
vim.keymap.set('n', '<leader>J', ':resize +5<CR>', noremap)
vim.keymap.set('n', '<leader>K', ':resize -5<CR>', noremap)


------ BUFFERS

vim.keymap.set('n', '<C-n>', ':bn<CR>', noremap)
vim.keymap.set('n', '<C-p>', ':bp<CR>', noremap)
-- vim.keymap.set('', '<C-x>', ':bdelete<CR>')
vim.keymap.set('n', '<C-x>', ':lua MiniBufremove.delete()<CR>', noremap)


------ SEARCHING

vim.opt.hlsearch = true     -- highligh matched search terms
vim.opt.incsearch = true    -- start searching as you type letters
vim.opt.ignorecase = true   -- make searches case sensitive
vim.opt.smartcase = true    -- will search case sensitive if uppercase present, needs ignorecase set

vim.keymap.set('', '<BS>', ':noh<CR>', remap) -- clear search highlight
vim.opt.inccommand = 'nosplit' -- live visualization of substitutions

-- Search inside visual selection. `silent = false` makes effect immediately.
vim.keymap.set('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
vim.keymap.set('x', '*', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
vim.keymap.set('x', '#', [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])


-- ------ TERMINAL
--
-- -- Maps ESC to exit terminal's insert mode
-- vim.cmd([[
-- if has('nvim')
--     vim.keymap.set('t',  <Esc> <C-\><C-n>
--     vim.keymap.set('t',  <leader>q <C-\><C-n>
-- endif
-- ]])
--
-- -- open a new horizontal split with a terminal
-- vim.keymap.set('n', '<leader>T', ':new +terminal<CR>', noremap)
-- vim.keymap.set('t', '<leader>T', '<C-\\><C-n>:new +terminal<CR>', noremap)
--
-- -- open a new vertical split with a terminal
-- vim.keymap.set('n', '<leader>t', ':vnew +terminal<CR>', noremap)
-- vim.keymap.set('t', '<leader>t', '<C-\\><C-n>:vnew +terminal<cr>', noremap)
--
-- vim.cmd([[
-- augroup startup
-- 	autocmd!
-- 	" avoid nesting by adding a buffer to the existing vim session (credit justinmk)
-- 	autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
-- 		\ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
-- 		\ |let g:f=fnameescape(expand('%:p'))
-- 		\ |noau bwipe
-- 		\ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
-- 		\ |call rpcrequest(g:r, "nvim_command", "call lib#SetNumberDisplay()")
-- 		\ |qa
-- 		\ |endif
-- augroup END
--
-- augroup neovim_terminal
--     autocmd!
--     " Enter Terminal-mode (insert) automatically
--     autocmd TermOpen * startinsert
--     " Disables number lines on terminal buffers
--     autocmd TermOpen * :set nonumber norelativenumber
--     " revim.keymap.set('', 'Escape to leave terminal mode
--     autocmd TermOpen * vim.keymap.set('t', '<buffer> <Esc> <c-\><c-n>
-- augroup END
-- ]])
--
