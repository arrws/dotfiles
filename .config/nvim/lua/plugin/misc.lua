
-- LuaLine
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "mtheme",
        component_separators = { "|", "|" },
        section_separators = { "", "" }, -- {'', ''},
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { { "mode", upper = true } },
        lualine_b = { { "branch", icon = "b" } },
        lualine_c = { { "filename", file_status = true } },
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
    extensions = { "fzf" },
})


-- HOP
require("hop").setup({}) -- keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
nmap('s', ':HopChar1<CR>')
nmap('S', ':HopChar2<CR>')
-- nmap('x', ':HopPattern<CR>')
-- nmap('s', ':HopWord<CR>')
-- nmap('F', ':HopLine<CR>')


-- Colorizer
require("colorizer").setup()

