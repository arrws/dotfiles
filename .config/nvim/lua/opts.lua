---@diagnostic disable: undefined-global

vim.opt.termguicolors = true    -- true color support

vim.opt.clipboard = "unnamedplus"   -- Copy/paste with system clipboard

vim.opt.mouse = "a"             -- enable mouse mode
vim.opt.hidden = true           -- do not save when swithing buffers -> work with multiple files easier
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.timeout = true          -- time to wait for mapped sequence
vim.opt.timeoutlen = 1000       -- time to wait for mapped sequence
vim.opt.ttimeoutlen = 10        -- time to wait for key code sequence

vim.opt.history = 1000          -- status line commands history
vim.opt.showcmd = true          -- show in status line the command you're typing
vim.opt.laststatus = 2          -- status line
vim.opt.cmdheight = 1           -- height status line

vim.opt.wildmenu = true         -- status line menu
vim.opt.wildmode = "full"
vim.opt.wildoptions = "tagfile"

vim.opt.number = true           -- or relativenumber
vim.opt.numberwidth = 1         -- number column width
vim.opt.ruler = true            -- show current column in status bar right corner
                                -- set signcolumn=number merge sign and numbers gutter golumns
                                -- set signcolumn=yes:1 always show sign column
vim.opt.signcolumn = "auto:1"   -- sign column
vim.opt.foldcolumn = "0"        -- fold column width
vim.opt.fillchars = "vert:│"    -- vertical bar delimiter

vim.opt.cursorline = true       -- highlight current line
vim.opt.showmatch = true        -- show matching braces

vim.opt.undofile = true         -- save undo history

vim.opt.splitbelow = true       -- new window below current
vim.opt.splitright = true       -- new window right of current

vim.opt.diffopt:append "vertical"   -- vertical diffs


-- spacing
vim.opt.expandtab = true        -- TAB is expanded into spaces
vim.opt.shiftwidth = 4          -- num space characters for indent
vim.opt.tabstop = 4             -- num space characters for TAB key
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.linespace = 0


-- searching
vim.opt.hlsearch = true         -- highligh matched search terms
vim.opt.incsearch = true        -- start searching as you type letters
vim.opt.ignorecase = true       -- make searches case sensitive
vim.opt.smartcase = true        -- will search case sensitive if uppercase present, needs ignorecase set

vim.opt.inccommand = "nosplit"  -- live visualization of substitutions

