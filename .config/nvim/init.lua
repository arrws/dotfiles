---@diagnostic disable: undefined-global

vim.cmd "set termguicolors"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("xtheme").load()
require "opts"
require("lazy").setup("plugins", {
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.8, height = 0.8 },
        wrap = true, -- wrap the lines in the ui

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "single",
        title = " Lazy Manager ",
        pills = true,

        icons = {
            loaded = "◼",
            not_loaded = "□",
            cmd = " - ",
            config = " - ",
            event = " - ",
            ft = " - ",
            init = " - ",
            import = " - ",
            keys = " - ",
            lazy = " - ",
            plugin = " - ",
            runtime = " - ",
            require = " - ",
            source = " - ",
            start = " ➜ ",
            task = " - ",
            list = {
                "*",
                "-",
            },
        },
    },
    checker = {
        enabled = false, -- automatically check for plugin updates
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
    },
    change_detection = {
        enabled = false, -- automatically check for config file changes and reload the ui
        notify = true, -- get a notification when changes are found
    },
})
