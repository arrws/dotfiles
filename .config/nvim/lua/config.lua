vim.o.termguicolors = true -- true color support
vim.o.swapfile = false
vim.o.wildoptions = "tagfile" -- show options across the status bar

vim.o.clipboard = "unnamed" -- Copy/paste with system clipboard

vim.o.ttimeoutlen = 10 -- time to wait for key code sequence (default: 50)

vim.o.number = true -- show line numbers
vim.o.numberwidth = 1 -- number column width (default: 4)
vim.o.signcolumn = "auto:1" -- sign column with max width 1
vim.o.fillchars = "vert:│" -- vertical bar delimiter

vim.o.cursorline = true -- highlight current line
vim.o.showmatch = true -- show matching braces

vim.o.undofile = true -- save undo history

vim.o.splitbelow = true -- new window below current
vim.o.splitright = true -- new window right of current

vim.opt.diffopt:append "vertical" -- vertical diffs

vim.o.expandtab = true -- TAB is expanded into spaces
vim.o.shiftwidth = 4 -- indent width (default: 8)
vim.o.tabstop = 4 -- tab width (default: 8)
vim.o.softtabstop = 4 -- backspace removes 4 spaces
vim.o.smartindent = true
vim.o.breakindent = true

vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true  -- case sensitive if uppercase present

-- vim.o.autowrite = true        -- auto save on certain events
-- vim.o.autowriteall = true        -- auto save on buffer/windows switch

local map = vim.keymap.set

-- for native autocomplete
vim.o.complete = ".,o"                             -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noselect,popup" -- add 'popup' for docs (sometimes)
vim.o.autocomplete = true
vim.o.pumheight = 5


map("n", "<BS>", ":noh<CR>", { desc = "Clear search highlight" })

-- Search inside visual selection. `silent = false` makes effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })


-- leader
map("n", ";", "<Nop>", { noremap = true })
vim.g.mapleader = ";"

map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<leader>w", ":w<cr>", { noremap = true, desc = "Save file" })
map("n", "<leader>t", ":term<cr>", { noremap = true, desc = "Enter terminal mode" })
-- map("n", "<leader>q", ":q!<cr>", { noremap = true, desc = "Quit without saving" })

--- buffers
map("n", "<leader>q", function() -- ':bdelete<CR>'
    require("mini.bufremove").delete(0, false)
end, { noremap = true, desc = "Delete buffer" })

-- redo with U instead of Ctrl+R
map("n", "U", "<C-R>", { noremap = true, desc = "Redo" })
map("n", "<C-R>", "<Nop>", { noremap = true })

map("n", "gO", "O<ESC>j", { desc = "Put empty line above" })
map("n", "go", "o<ESC>k", { desc = "Put empty line below" })

-- overrides reselect last visual selection
map("n", "gv", "`[v`]", { desc = "Select last pasted, yanked or changed text" })

-- block visual fallback
map('n', '<leader>v', '<C-v>', { noremap = true })

-- Block insert in line visual mode
map("x", "I", function()
    return vim.fn.mode() == "V" and "^<C-v>I" or "I"
end, { expr = true, desc = "Insert at start of each line" })
map("x", "A", function()
    return vim.fn.mode() == "V" and "$<C-v>A" or "A"
end, { expr = true, desc = "Insert at end of each line" })

-- make dot work over visual line selections
map("x", ".", ":norm.<CR>", { noremap = true, desc = "Repeat last command on selection" })

-- " copy selection to gui-clipboard
-- xnoremap Y "+y

-- highlight on yank
local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- yank all
map("n", "yY", "gg0yG<C-o>", { noremap = true, desc = "Copy all buffer content" })

-- overload ' to both set and jump to mark
-- use only global marks
-- clear marks with: delmarks! | delmarks A-Z0-9
for i in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
    local mark = string.upper(i)
    -- map("n", "m" .. i, "m" .. mark, { noremap = true })
    -- map("n", "'" .. i, "'" .. mark, { noremap = true })
    map("n", "'" .. i, function()
        local pos = vim.api.nvim_get_mark(mark, {})
        if pos[1] == 0 then
            vim.cmd("mark " .. mark)     -- set mark
        else
            vim.cmd("normal! `" .. mark) -- jump to mark
        end
    end, { desc = "Toggle mark " .. mark })
end

-- disable space so that it won't move cursor
map("n", "<SPACE>", "<Nop>", { noremap = true })

------ splits
map("n", "<D-\\>", "<C-w>v", { noremap = true, desc = "Vertical split" })
map("n", "<D-S-\\>", "<C-w>s", { noremap = true, desc = "Horizontal split" })
map("n", "<D-q>", "<C-w>q", { noremap = true, desc = "Quit split" })
map("n", "<D-l>", "<C-w>l", { noremap = true, desc = "Move to right split" })
map("n", "<D-h>", "<C-w>h", { noremap = true, desc = "Move to left split" })
map("n", "<D-j>", "<C-w>j", { noremap = true, desc = "Move to bottom split" })
map("n", "<D-k>", "<C-w>k", { noremap = true, desc = "Move to top split" })
map("n", "<D-S-l>", ":vertical resize -4<CR>", { noremap = true, desc = "Resize split left" })
map("n", "<D-S-h>", ":vertical resize +4<CR>", { noremap = true, desc = "Resize split right" })
map("n", "<D-S-j>", ":horizontal resize -2<CR>", { noremap = true, desc = "Resize split up" })
map("n", "<D-S-k>", ":horizontal resize +2<CR>", { noremap = true, desc = "Resize split down" })
-- map("n", "r", "<D-w>x", {noremap = true}) -- exchange current with left window
-- map("n", "=", "<D-w>=", {noremap = true}) -- reset all windows
