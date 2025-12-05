require "config"
require("xtheme").load()

-- Load lua/plugins/*
do
    local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
    local files = vim.fn.globpath(plugin_dir, "*.lua", false, true)
    table.sort(files)
    for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        local ok, err = pcall(require, "plugins." .. name)
        if not ok then
            vim.schedule(function()
                vim.notify("Error loading plugin module '" .. name .. "': " .. err, vim.log.levels.ERROR)
            end)
        end
    end
end

-- "https://github.com/askfiy/visual_studio_code"
-- "https://github.com/github/copilot.vim"
-- "https://github.com/chentoast/marks.nvim"
-- "https://github.com/nvimdev/indentmini.nvim"
-- "https://github.com/nvim-mini/mini.nvim"
-- "https://github.com/nvim-tree/nvim-tree.lua"
-- "https://github.com/nvim-lualine/lualine.nvim"
-- "https://github.com/nvim-treesitter/nvim-treesitter"
-- "https://github.com/nvim-lua/plenary.nvim"
-- "https://github.com/nvim-telescope/telescope.nvim"
-- "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
-- "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
-- "https://github.com/nvim-telescope/telescope-ui-select.nvim"
-- "https://github.com/neovim/nvim-lspconfig"
