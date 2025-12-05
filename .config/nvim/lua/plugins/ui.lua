-- Lualine
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

-- -- Marks
-- vim.pack.add { { src = "https://github.com/chentoast/marks.nvim" } }
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         vim.defer_fn(function()
--             require("marks").setup {
--                 default_mappings = false,
--                 mappings = {
--                     next = "]'",
--                     prev = "['",
--                 },
--             }
--             -- Use only global marks
--             for i in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
--                 vim.keymap.set("n", "m" .. i, "m" .. string.upper(i), { noremap = true })
--                 vim.keymap.set("n", "'" .. i, "'" .. string.upper(i), { noremap = true })
--                 vim.keymap.set("n", "dm" .. i, ":delmarks " .. string.upper(i) .. "<CR>", { noremap = true })
--             end
--         end, 50)
--     end,
--     once = true,
-- })

-- -- vscode infinite hack
-- vim.pack.add { { src = "https://github.com/askfiy/visual_studio_code" } }
-- require("visual_studio_code").setup {
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
-- }
-- vim.cmd "colorscheme visual_studio_code"
-- local c = require "xtheme.colors"
-- c.black = "#1B1B1C"
-- c.blackish = "#3E3E40"
-- c.blacker = "#1E1E1E"
-- c.white = "#F1F1F1"
-- vim.api.nvim_set_hl(0, "@keyword.import.python", { fg = "#C586C0" })
-- vim.api.nvim_set_hl(0, "@keyword.return.python", { fg = "#C586C0" })
-- vim.api.nvim_set_hl(0, "@keyword.conditional.python", { fg = "#C586C0" })
-- vim.api.nvim_set_hl(0, "@keyword.exception.python", { fg = "#C586C0" })
-- vim.api.nvim_set_hl(0, "@keyword.python", { fg = "#C586C0" })
-- vim.api.nvim_set_hl(0, "@keyword.coroutine.python", { fg = "#569CD6" })
-- vim.api.nvim_set_hl(0, "@function.builtin.python", { fg = "#DCDCAA" })
-- vim.api.nvim_set_hl(0, "@type.builtin.python", { fg = "#4EC9B0" })
-- vim.api.nvim_set_hl(0, "@variable.python", { fg = "#9CDCFE" })
-- vim.api.nvim_set_hl(0, "@variable.builtin.python", { fg = "#9CDCFE", italic = true })
-- vim.api.nvim_set_hl(0, "@lsp.type.variable.python", { fg = "#9CDCFE" })
-- vim.api.nvim_set_hl(0, "@constant.python", { fg = "#4FC1FF" })
-- require("visual_studio_code.utils").hl.bulk_set {
--     StatusLine = { bg = c.black },
--     StatusLineNC = { bg = c.black },
--     IndentLine = { fg = c.blackish },
--     IndentLineCurrent = { fg = c.blackish, bold = true },
--     VertSplit = { fg = c.blackish },
--     WinSeparator = { fg = c.blackish },
--     NvimTreeNormal = { fg = c.grey_4 },
--     NvimTreeFolderName = { fg = c.grey_4 },
--     NvimTreeFolderIcon = { fg = c.grey_4 },
-- }
