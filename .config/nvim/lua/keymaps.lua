local map = vim.keymap.set

map("n", "<BS>", ":noh<CR>", { desc = "Clear search highlight" })

-- Search inside visual selection. `silent = false` makes effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- map("n", "<C-K>", vim.lsp.buf.definition, { desc = "go to definition" })
map("n", "<C-K>", function()
    local clients = vim.lsp.get_active_clients { bufnr = 0 }
    -- Check if any active LSP client supports goToDefinition
    for _, client in ipairs(clients) do
        if client.server_capabilities.definitionProvider then
            vim.lsp.buf.definition()
            return
        end
    end
    -- Fall back to gf if no LSP definition available
    vim.cmd "normal! gf"
end, { silent = true, noremap = true, desc = "Go to definition or follow file" })

-- leader
map("n", ";", "<Nop>", { noremap = true })
vim.g.mapleader = ";"

map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

map("n", "<leader>w", ":w<cr>", { noremap = true, desc = "Save file" })
map("n", "<leader>q", ":q!<cr>", { noremap = true, desc = "Quit without saving" })
map("n", "<leader>t", ":term<cr>", { noremap = true, desc = "Enter terminal mode" })

--- buffers
map("n", "<leader>Q", function() -- ':bdelete<CR>'
    require("mini.bufremove").delete(0, false)
end, { noremap = true, desc = "Delete buffer" })

-- redo with U instead of Ctrl+R
map("n", "U", "<C-R>", { noremap = true, desc = "Redo" })
map("n", "<C-R>", "<Nop>", { noremap = true })

map("n", "gO", "O<ESC>j", { desc = "Put empty line above" })
map("n", "go", "o<ESC>k", { desc = "Put empty line below" })

-- overrides reselect last visual selection
map("n", "gv", "`[v`]", { desc = "Select last pasted, yanked or changed text" })

-- Block insert in line visual mode
map("x", "I", function()
    return vim.fn.mode() == "V" and "^<C-v>I" or "I"
end, { expr = true, desc = "Insert at start of each line" })
map("x", "A", function()
    return vim.fn.mode() == "V" and "$<C-v>A" or "A"
end, { expr = true, desc = "Insert at end of each line" })

-- make dot work over visual line selections
map("x", ".", ":norm.<CR>", { noremap = true, desc = "Repeat last command on selection" })

-- highlight on yank
local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- disable space so that it won't move cursor
map("n", "<SPACE>", "<Nop>", { noremap = true })

------ splits
map("n", "<D-\\>", "<C-w>v", { noremap = true, desc = "Vertical split" })
map("n", "<D-S-\\>", "<C-w>s", { noremap = true, desc = "Horizontal split" })
map("n", "<D-l>", "<C-w>l", { noremap = true, desc = "Move to right split" })
map("n", "<D-h>", "<C-w>h", { noremap = true, desc = "Move to left split" })
map("n", "<D-j>", "<C-w>j", { noremap = true, desc = "Move to bottom split" })
map("n", "<D-k>", "<C-w>k", { noremap = true, desc = "Move to top split" })
map("n", "<D-S-l>", ":vertical resize -4<CR>", { noremap = true, desc = "Resize split left" })
map("n", "<D-S-h>", ":vertical resize +4<CR>", { noremap = true, desc = "Resize split right" })
map("n", "<D-S-j>", ":horizontal resize -2<CR>", {noremap = true, desc = "Resize split up"})
map("n", "<D-S-k>", ":horizontal resize +2<CR>", {noremap = true, desc = "Resize split down"})
-- map("n", "r", "<D-w>x", {noremap = true}) -- exchange current with left window
-- map("n", "=", "<D-w>=", {noremap = true}) -- reset all windows
