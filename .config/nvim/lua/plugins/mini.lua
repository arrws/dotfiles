vim.pack.add {
    { src = "https://github.com/nvimdev/indentmini.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
}

require("indentmini").setup { char = "│" }

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
