------ LuaLine

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "xtheme",
        component_separators = {"|", "|"},
        section_separators = {"", ""}, -- {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {{"mode", upper = true}},
        lualine_b = {{"branch", icon = "b"}},
        lualine_c = {{"filename", file_status = true, path = 1}},
        lualine_x = {"encoding", "fileformat", "filetype", "progress"},
        lualine_y = {"location"},
        lualine_z = {}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {"fzf"}
})
