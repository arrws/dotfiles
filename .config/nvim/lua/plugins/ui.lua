return {
    {
        "knubie/vim-kitty-navigator",
        build = "cp ./*.py ~/.config/kitty/",
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup {
                "*",
                lua = { mode = "foreground" },
            }
        end,
    },

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        config = function()
            require("marks").setup {
                -- whether to map keybinds or not. default true
                default_mappings = false,
                -- which builtin marks to show. default {}
                bjiltin_marks = { ".", "<", ">", "^" },
                refresh_interval = 250, -- 150
                mappings = {
                    next = "]'",
                    prev = "['",
                },
            }
            -- use only global marks - it's stupid but it works
            for i in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
                -- vim.keymap.set("n", "ma", "mA", {noremap = true})
                vim.keymap.set("n", "m" .. i, "m" .. string.upper(i), { noremap = true })
                -- vim.keymap.set("n", "'a", "'A", {noremap = true})
                vim.keymap.set("n", "'" .. i, "'" .. string.upper(i), { noremap = true })
                -- vim.keymap.set("n", "dma", ":delmarks A<CR>", {noremap = true})
                vim.keymap.set("n", "dm" .. i, ":delmarks " .. string.upper(i) .. "<CR>", { noremap = true })
            end
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = (require "xtheme.line"),
                component_separators = { "|", "|" },
                section_separators = { "", "" },
                disabled_filetypes = {},
            },
            sections = {
                lualine_a = { { "mode", upper = true } },
                lualine_b = { { "branch", icon = "b" } },
                lualine_c = { { "filename", file_status = true, path = 1 } },
                lualine_x = { "encoding", "fileformat", "filetype", "progress" },
                lualine_y = { "location" },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = {},
        },
    },
}
