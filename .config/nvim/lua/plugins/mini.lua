require("xtheme").load()

-- -- Visual Studio Code
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
-- local c = require "xtheme.colors"
-- c.black = "#1B1B1C"
-- c.blackish = "#3E3E40"
-- c.blacker = "#1E1E1E"
-- c.white = "#F1F1F1"
-- require("visual_studio_code.utils").hl.bulk_set {
--     StatusLine = { bg = c.black },
--     StatusLineNC = { bg = c.black },
--     IndentLine = { fg = c.blackish },
--     IndentLineCurrent = { fg = c.blackish, bold = true },
--     VertSplit = { fg = c.blackish },
--     WinSeparator = { fg = c.blackish },
--     NvimTreeNormal = { fg = c.grey_4 },
--     NvimTreeFolderName = { fg = c.grey_4, bold = true },
--     NvimTreeFolderIcon = { fg = c.grey_4 },
-- }
-- vim.cmd "colorscheme visual_studio_code"

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

-- Mini
vim.pack.add { { src = "https://github.com/nvim-mini/mini.nvim" } }
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    callback = function()
        require("mini.diff").setup { -- :lua MiniDiff.toggle_overlay()
            view = {
                style = "sign", -- "number"
                signs = { add = "+", change = ">", delete = "-" },
            },
        }
        require("mini.bufremove").setup {}
        require("mini.splitjoin").setup {} -- gS
        require("mini.align").setup {}
        require("mini.surround").setup { n_lines = 200 }
        require("mini.jump").setup {}
        require("mini.jump2d").setup {}
        require("mini.move").setup {
            mappings = {
                -- Move visual selection. Defaults are Alt (Meta) + hjkl.
                left = "<left>",
                right = "<right>",
                down = "<down>",
                up = "<up>",
                -- Move current line
                line_left = "<left>",
                line_right = "<right>",
                line_down = "<down>",
                line_up = "<up>",
            },
        }
        vim.keymap.set({ "n", "o", "v" }, "]h", ":lua MiniDiff.goto_hunk('next')<CR>", { noremap = true })
        vim.keymap.set({ "n", "o", "v" }, "[h", ":lua MiniDiff.goto_hunk('prev')<CR>", { noremap = true })
    end,
    once = true,
})

-- Indent
vim.pack.add { { src = "https://github.com/nvimdev/indentmini.nvim" } }
require("indentmini").setup()

-- Marks
vim.pack.add { { src = "https://github.com/chentoast/marks.nvim" } }
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.defer_fn(function()
            require("marks").setup {
                default_mappings = false,
                mappings = {
                    next = "]'",
                    prev = "['",
                },
            }
            -- Use only global marks
            for i in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
                vim.keymap.set("n", "m" .. i, "m" .. string.upper(i), { noremap = true })
                vim.keymap.set("n", "'" .. i, "'" .. string.upper(i), { noremap = true })
                vim.keymap.set("n", "dm" .. i, ":delmarks " .. string.upper(i) .. "<CR>", { noremap = true })
            end
        end, 50)
    end,
    once = true,
})
