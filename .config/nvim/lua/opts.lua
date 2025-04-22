---@diagnostic disable: undefined-global

vim.opt.mouse = "a"           -- enable mouse mode
vim.opt.hidden = true         -- do not save when swithing buffers -> work with multiple files easier
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.history = 1000        -- status line commands history
vim.opt.showcmd = true        -- show in status line the command you're typing
vim.opt.laststatus = 2        -- status line
vim.opt.cmdheight = 1         -- height status line

vim.opt.wildmenu = true       -- status line menu
vim.opt.wildmode = "full"
vim.opt.wildoptions = "tagfile"

vim.opt.number = true         -- or relativenumber
vim.opt.numberwidth = 1       -- number column width
vim.opt.ruler = true          -- show current column in status bar right corner
                              -- set signcolumn=number	           -- merge sign and numbers gutter golumns
                              -- set signcolumn=yes:1              -- always show sign column
vim.opt.signcolumn = "auto:1" -- sign column
vim.opt.foldcolumn = "0"      -- fold column width
vim.opt.fillchars = "vert:│"  -- vertical bar delimiter

vim.opt.cursorline = true     -- highlight current line
vim.opt.showmatch = true      -- show matching braces

vim.opt.undofile = true       -- save undo history

vim.opt.diffopt:append "vertical"

-- when running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen, which greatly speeds it up, upto 6-7x faster
vim.opt.lazyredraw = true


-- spacing
vim.opt.expandtab = true -- TAB is expanded into spaces
vim.opt.shiftwidth = 4 -- num space characters for indent
vim.opt.tabstop = 4 -- num space characters for TAB key
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.linespace = 0


-- searching
vim.opt.hlsearch = true -- highligh matched search terms
vim.opt.incsearch = true -- start searching as you type letters
vim.opt.ignorecase = true -- make searches case sensitive
vim.opt.smartcase = true -- will search case sensitive if uppercase present, needs ignorecase set

vim.keymap.set("n", "<BS>", ":noh<CR>") -- clear search highlight
vim.opt.inccommand = "nosplit" -- live visualization of substitutions

-- Search inside visual selection. `silent = false` makes effect immediately.
vim.keymap.set("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
vim.keymap.set("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
vim.keymap.set("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])


vim.diagnostic.config {
    virtual_lines = false,
    -- -- Only show virtual line diagnostics for the current cursor line
    -- virtual_lines = { current_line = true },
}


-- leader
vim.keymap.set("n", ";", "<Nop>", {noremap = true})
vim.g.mapleader = ";"
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 10


vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("", "<leader>q", ":q!<cr>", {noremap = true})
vim.keymap.set("n", "<leader>w", ":w<cr>", {noremap = true})
vim.keymap.set("i", "<leader>w", "<C-c>:w<cr>", {noremap = true})

-- -- reverse brackets
-- vim.keymap.set({ "n", "o", "v" }, "[", "]", { noremap = true })
-- vim.keymap.set({ "n", "o", "v" }, "]", "[", { noremap = true })
-- vim.keymap.set({ "n", "o", "v" }, "{", "}", { noremap = true })
-- vim.keymap.set({ "n", "o", "v" }, "}", "{", { noremap = true })
-- vim.keymap.set({ "n", "o", "v" }, "[d", vim.diagnostic.goto_next, { noremap = true })
-- vim.keymap.set({ "n", "o", "v" }, "]d", vim.diagnostic.goto_prev, { noremap = true })

-- redo with U instead of Ctrl+R
vim.keymap.set("n", "U", "<C-R>", {noremap = true})
vim.keymap.set("n", "<C-R>", "Nup", {noremap = true})

-- add newline without insert
vim.keymap.set("n", "go", "o<ESC>k", { desc = "Put empty line above" })
vim.keymap.set("n", "gO", "O<ESC>j", { desc = "Put empty line below" })

-- avoid resetting
vim.keymap.set("n", "K", "<Nop>")

-- Copy/paste with system clipboard
vim.keymap.set("n", "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "gp", '"+p', { desc = "Paste below from system clipboard" })
vim.keymap.set("n", "gP", '"+P', { desc = "Paste above from system clipboard" })

-- Select recently pasted, yanked or changed text
vim.keymap.set("n", "gv", "`[v`]", { desc = 'Select recently pasted, yanked or changed text' })

-- Block insert in line visual mode
vim.keymap.set('x', 'I', function() return vim.fn.mode() == 'V' and '^<C-v>I' or 'I' end, { expr = true })
vim.keymap.set('x', 'A', function() return vim.fn.mode() == 'V' and '$<C-v>A' or 'A' end, { expr = true })

-- make vim remember last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 1 and last_pos <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})

-- make dot work over visual line selections
-- enablea a simple form of dot repetition over visual line selections.
-- only simple operations that start from the beginning of a line be dot repeated.
vim.keymap.set("x", ".", ":norm.<CR>", {noremap = true})

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- disable space so that it won't move cursor
vim.keymap.set("n", "<SPACE>", "<Nop>", {noremap = true})


------ buffers
-- vim.keymap.set('', '<C-x', ':bdelete<CR>')
vim.keymap.set("n", "<C-x>", ":lua MiniBufremove.delete()<CR>", {noremap = true})


------ windows
vim.opt.splitbelow = true
vim.opt.splitright = true
-- automatically equalize splits when resized
vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    command = "wincmd ="
})

-- kitty compatible navigation
vim.keymap.set('n', '<Left-Mapping>', '<Cmd>KittyNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<Down-Mapping>', '<Cmd>KittyNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<Up-Mapping>', '<Cmd>KittyNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<Right-Mapping>', '<Cmd>KittyNavigateRight<CR>', { silent = true })

vim.keymap.set("n", "<leader>S", "<C-w>s", {noremap = true})
vim.keymap.set("n", "<leader>s", "<C-w>v", {noremap = true})
-- vim.keymap.set("n", "r", "<C-w>x", {noremap = true}) -- exchange current with left window
-- vim.keymap.set("n", "=", "<C-w>=", {noremap = true}) -- reset all windows
-- vim.keymap.set("n", "L", ":vertical resize +5<CR>", {noremap = true})
-- vim.keymap.set("n", "H", ":vertical resize -5<CR>", {noremap = true})
-- vim.keymap.set("n", "J", ":resize +5<CR>", {noremap = true})
-- vim.keymap.set("n", "K", ":resize -5<CR>", {noremap = true})

