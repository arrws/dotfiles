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
