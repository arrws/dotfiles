vim.pack.add { { src = "https://github.com/nvim-lualine/lualine.nvim" } }
require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = (require "xtheme.line"),
        component_separators = { "|", "|" },
        section_separators = { "", "" },
    },
    sections = {
        lualine_b = { "branch" },
        lualine_c = { { "filename", path = 3 } }, -- fullpath
    },
}

vim.pack.add { { src = "https://github.com/nvimdev/indentmini.nvim" } }
require("indentmini").setup() -- identation lines
