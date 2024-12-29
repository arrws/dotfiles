return {
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = (require "colors.xtheme_line"),
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

    {
        "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            -- include theme file and pass it to lush to apply
            require "lush"(require "colors.xtheme_lush")
        end,
    },
}
