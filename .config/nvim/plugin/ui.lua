vim.pack.add { { src = "https://github.com/nvim-lualine/lualine.nvim" } }
require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = (require "line"),
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

vim.pack.add { { src = "https://github.com/brenoprata10/nvim-highlight-colors" } }
require("nvim-highlight-colors").setup()
