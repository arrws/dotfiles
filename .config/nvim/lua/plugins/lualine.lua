vim.pack.add { { src = "https://github.com/nvim-lualine/lualine.nvim" } }

require("xtheme").load()

-- vim.pack.add { { src = "https://github.com/askfiy/visual_studio_code" } }
--
-- require("visual_studio_code").setup({
--     mode = "dark",
--     preset = true,
--     transparent = false,
--     expands = {
--         gitsigns = true,
--         nvim_tree = true,
--         lspconfig = true,
--         telescope = true,
--         nvim_treesitter = true,
--         indent_blankline = true,
--     },
--     hooks = {
--         before = function(conf, colors, utils) end,
--         after = function(conf, colors, utils) end,
--     },
-- })
--
-- vim.cmd('colorscheme visual_studio_code')
--
-- local c = require "xtheme.colors"
-- c.black         = "#1B1B1C"
-- c.blackish      = "#3E3E40"
-- c.blacker       = "#1E1E1E"
-- c.white         = "#F1F1F1"
--
-- require("visual_studio_code.utils").hl.bulk_set({
--     StatusLine =            { bg = c.black },
--     StatusLineNC =          { bg = c.black },
--     IndentLine =            { fg = c.blackish },
--     IndentLineCurrent =     { fg = c.blackish , bold = true },
--     VertSplit =             { fg = c.blackish },
--     WinSeparator =          { fg = c.blackish },
-- 	NvimTreeNormal =        { fg = c.grey_4 },
-- 	NvimTreeFolderName =    { fg = c.grey_4, bold = true },
-- 	NvimTreeFolderIcon =    { fg = c.grey_4 },
-- })

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
