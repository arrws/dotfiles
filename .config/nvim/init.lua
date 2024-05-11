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

-- disable some builtin vim plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

require "opts"
require("lazy").setup("plugins", {
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = { width = 0.8, height = 0.8 },
        wrap = true, -- wrap the lines in the ui

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",
        title = " Lazy Manager ",
        pills = true,

        icons = {
            cmd = " [cmd] ",
            config = " [config] ",
            event = " [event] ",
            ft = " [ft] ",
            init = " ",
            import = " ",
            keys = " [keys] ",
            lazy = " [lazy] ",
            loaded = "●",
            not_loaded = "○",
            plugin = " [plug] ",
            runtime = " ",
            require = " [req] ",
            source = " ➜  ",
            start = " ➜  ",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
    },
    checker = {
        enabled = false,    -- automatically check for plugin updates
        notify = true,      -- get a notification when new updates are found
        frequency = 3600,   -- check for updates every hour
    },
    change_detection = {
        enabled = true,     -- automatically check for config file changes and reload the ui
        notify = true,      -- get a notification when changes are found
    },
})
