local map = vim.keymap.set

map("n", "<BS>", ":noh<CR>") -- clear search highlight

-- Search inside visual selection. `silent = false` makes effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])


vim.diagnostic.config {
    virtual_lines = false,
    -- -- Only show virtual line diagnostics for the current cursor line
    -- virtual_lines = { current_line = true },
}

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
end, { silent = true, noremap = true })


-- leader
map("n", ";", "<Nop>", {noremap = true})
vim.g.mapleader = ";"


map("i", "jk", "<esc>")

map("n", "<leader>q", ":q!<cr>", {noremap = true})
map("n", "<leader>w", ":w<cr>", {noremap = true})
map("i", "<leader>w", "<C-c>:w<cr>", {noremap = true})

-- -- reverse brackets
-- map({ "n", "o", "v" }, "[", "]", { noremap = true })
-- map({ "n", "o", "v" }, "]", "[", { noremap = true })
-- map({ "n", "o", "v" }, "{", "}", { noremap = true })
-- map({ "n", "o", "v" }, "}", "{", { noremap = true })
-- map({ "n", "o", "v" }, "[d", vim.diagnostic.goto_next, { noremap = true })
-- map({ "n", "o", "v" }, "]d", vim.diagnostic.goto_prev, { noremap = true })

-- redo with U instead of Ctrl+R
map("n", "U", "<C-R>", { noremap = true, desc = "Redo" })
map("n", "<C-R>", "<Nop>", { noremap = true })

-- add newline without insert
map("n", "gO", "O<ESC>j", { desc = "Put empty line above" })
map("n", "go", "o<ESC>k", { desc = "Put empty line below" })

-- avoid resetting
-- map("n", "K", "<Nop>") -- should be go to definition

-- Copy/paste with system clipboard
map("n", "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "gp", '"+p', { desc = "Paste below from system clipboard" })
map("n", "gP", '"+P', { desc = "Paste above from system clipboard" })

-- Select recently pasted, yanked or changed text
map("n", "gv", "`[v`]", { desc = 'Select recently pasted, yanked or changed text' })

-- Block insert in line visual mode
map('x', 'I', function() return vim.fn.mode() == 'V' and '^<C-v>I' or 'I' end, { expr = true })
map('x', 'A', function() return vim.fn.mode() == 'V' and '$<C-v>A' or 'A' end, { expr = true })

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
map("n", "<SPACE>", "<Nop>", { noremap = true, desc = "Disable space movement" })


------ buffers
-- map('', '<C-x', ':bdelete<CR>')
map("n", "<C-x>", function()
    require("mini.bufremove").delete(0, false)
end, { noremap = true, desc = "Delete buffer" })


------ splits
map("n", "<leader>s", "<C-w>v", { noremap = true, desc = "Vertical split" })
map("n", "<leader>S", "<C-w>s", { noremap = true, desc = "Horizontal split" })
map("n", "<D-l>", "<C-w>l", {noremap = true, desc = "Move to right split"})
map("n", "<D-h>", "<C-w>h", {noremap = true, desc = "Move to left split"})
map("n", "<D-j>", "<C-w>j", {noremap = true, desc = "Move to bottom split"})
map("n", "<D-k>", "<C-w>k", {noremap = true, desc = "Move to top split"})
map("n", "<D-S-l>", ":vertical resize +5<CR>", {noremap = true, desc = "Resize split right"})
map("n", "<D-S-h>", ":vertical resize -5<CR>", {noremap = true, desc = "Resize split left"})
-- map("n", "<D-S-j>", ":resize +5<CR>", {noremap = true, desc = "Resize split down"})
-- map("n", "<D-S-k>", ":resize -5<CR>", {noremap = true, desc = "Resize split up"})
-- map("n", "r", "<D-w>x", {noremap = true}) -- exchange current with left window
-- map("n", "=", "<D-w>=", {noremap = true}) -- reset all windows

-- automatically equalize splits when resized
vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    command = "wincmd ="
})

