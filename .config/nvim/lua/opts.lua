---@diagnostic disable: undefined-global

vim.opt.termguicolors = true    -- true color support
vim.opt.swapfile = false
vim.opt.wildoptions = "tagfile" -- show options across the status bar

vim.opt.clipboard = "unnamed"   -- Copy/paste with system clipboard

vim.opt.ttimeoutlen = 10        -- time to wait for key code sequence (default: 50)

vim.opt.number = true           -- show line numbers
vim.opt.numberwidth = 1         -- number column width (default: 4)
vim.opt.signcolumn = "auto:1"   -- sign column with max width 1
vim.opt.fillchars = "vert:│"    -- vertical bar delimiter

vim.opt.cursorline = true       -- highlight current line
vim.opt.showmatch = true        -- show matching braces

vim.opt.undofile = true         -- save undo history

vim.opt.splitbelow = true       -- new window below current
vim.opt.splitright = true       -- new window right of current

vim.opt.diffopt:append "vertical"   -- vertical diffs

vim.opt.expandtab = true        -- TAB is expanded into spaces
vim.opt.shiftwidth = 4          -- indent width (default: 8)
vim.opt.tabstop = 4             -- tab width (default: 8)
vim.opt.softtabstop = 4         -- backspace removes 4 spaces
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.opt.ignorecase = true       -- case insensitive search
vim.opt.smartcase = true        -- case sensitive if uppercase present

