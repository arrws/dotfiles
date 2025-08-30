vim.pack.add { { src = "https://github.com/chentoast/marks.nvim" } }

-- Marks.nvim setup (lazy load on VeryLazy)
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.defer_fn(function()
            require("marks").setup {
                default_mappings = false,
                builtin_marks = { ".", "<", ">", "^" },
                refresh_interval = 250,
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
