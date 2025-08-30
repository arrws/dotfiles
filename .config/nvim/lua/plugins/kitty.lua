vim.pack.add { { src = "https://github.com/knubie/vim-kitty-navigator" } }

-- Build vim-kitty-navigator
local kitty_nav_path = vim.fn.stdpath "data" .. "/site/pack/packages/start/vim-kitty-navigator"
if vim.fn.isdirectory(kitty_nav_path) == 1 then
    local kitty_config = vim.fn.expand "~/.config/kitty/"
    if vim.fn.isdirectory(kitty_config) == 1 then
        local dest_file = kitty_config .. "/pass_keys.py"
        if vim.fn.filereadable(dest_file) == 0 then
            vim.fn.system("cp " .. kitty_nav_path .. "/*.py " .. kitty_config)
        end
    end
end

-- kitty compatible navigation
local map = vim.keymap.set
map("n", "<Left-Mapping>", "<Cmd>KittyNavigateLeft<CR>", { silent = true })
map("n", "<Down-Mapping>", "<Cmd>KittyNavigateDown<CR>", { silent = true })
map("n", "<Up-Mapping>", "<Cmd>KittyNavigateUp<CR>", { silent = true })
map("n", "<Right-Mapping>", "<Cmd>KittyNavigateRight<CR>", { silent = true })

map("n", "<leader>S", "<C-w>s", { noremap = true, desc = "Horizontal split" })
map("n", "<leader>s", "<C-w>v", { noremap = true, desc = "Vertical split" })
-- map("n", "r", "<C-w>x", {noremap = true}) -- exchange current with left window
-- map("n", "=", "<C-w>=", {noremap = true}) -- reset all windows
-- map("n", "L", ":vertical resize +5<CR>", {noremap = true})
-- map("n", "H", ":vertical resize -5<CR>", {noremap = true})
-- map("n", "J", ":resize +5<CR>", {noremap = true})
-- map("n", "K", ":resize -5<CR>", {noremap = true})
