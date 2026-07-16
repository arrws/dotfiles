-- OPTIONS

-- Disable netrw before plugins load (nvim-tree handles file browsing)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.termguicolors = true -- true color support
vim.o.swapfile = false
vim.o.wildoptions = "tagfile" -- show options across the status bar

vim.o.clipboard = "unnamedplus" -- Copy/paste with system clipboard

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
vim.o.breakindent = true

vim.o.ignorecase = true -- case insensitive search
vim.o.smartcase = true  -- case sensitive if uppercase present

-- vim.o.autowrite = true        -- auto save on certain events
-- vim.o.autowriteall = true        -- auto save on buffer/windows switch

vim.g.mapleader = ";"
local map = vim.keymap.set

-- for native autocomplete
vim.o.complete = ".,o"                             -- use buffer and omnifunc
vim.o.completeopt = "fuzzy,menuone,noselect,popup" -- add 'popup' for docs (sometimes)
vim.o.autocomplete = true
vim.o.pumheight = 5


require("theme").load()


-- KEYBINDINGS


map("n", "<BS>", ":noh<CR>", { desc = "Clear search highlight" })

-- Search inside visual selection. `silent = false` makes effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })


map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<leader>w", ":w<cr>", { desc = "Save file" })
map("n", "<leader>t", ":term<cr>", { desc = "Enter terminal mode" })
-- map("n", "<leader>q", ":q!<cr>", { desc = "Quit without saving" })

--- buffers
map("n", "<leader>q", function() -- ':bdelete<CR>'
    require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer" })

-- redo with U instead of Ctrl+R
map("n", "U", "<C-R>", { desc = "Redo" })
map("n", "<C-R>", "<Nop>")

map("n", "gO", "O<ESC>j", { desc = "Put empty line above" })
map("n", "go", "o<ESC>k", { desc = "Put empty line below" })

-- overrides reselect last visual selection
map("n", "gv", "`[v`]", { desc = "Select last pasted, yanked or changed text" })

-- block visual fallback
map('n', '<leader>v', '<C-v>')

-- Block insert in line visual mode
map("x", "I", function()
    return vim.fn.mode() == "V" and "^<C-v>I" or "I"
end, { expr = true, desc = "Insert at start of each line" })
map("x", "A", function()
    return vim.fn.mode() == "V" and "$<C-v>A" or "A"
end, { expr = true, desc = "Insert at end of each line" })

-- make dot work over visual line selections
map("x", ".", ":norm.<CR>", { desc = "Repeat last command on selection" })

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
map("n", "yY", "gg0yG<C-o>", { desc = "Copy all buffer content" })

-- overload ' to both set and jump to mark
-- use only global marks
-- clear marks with: delmarks! | delmarks A-Z0-9
for i in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
    local mark = string.upper(i)
    -- map("n", "m" .. i, "m" .. mark)
    -- map("n", "'" .. i, "'" .. mark)
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
map("n", "<SPACE>", "<Nop>")

------ splits
map("n", "<D-\\>", "<C-w>v", { desc = "Vertical split" })
map("n", "<D-S-\\>", "<C-w>s", { desc = "Horizontal split" })
map("n", "<D-q>", "<C-w>q", { desc = "Quit split" })
map("n", "<D-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<D-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<D-j>", "<C-w>j", { desc = "Move to bottom split" })
map("n", "<D-k>", "<C-w>k", { desc = "Move to top split" })
map("n", "<D-S-l>", ":vertical resize -4<CR>", { desc = "Resize split left" })
map("n", "<D-S-h>", ":vertical resize +4<CR>", { desc = "Resize split right" })
map("n", "<D-S-j>", ":horizontal resize -2<CR>", { desc = "Resize split up" })
map("n", "<D-S-k>", ":horizontal resize +2<CR>", { desc = "Resize split down" })
-- map("n", "r", "<D-w>x") -- exchange current with left window
-- map("n", "=", "<D-w>=") -- reset all windows
