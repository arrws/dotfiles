return {
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            vim.keymap.set(
                "i",
                "<C-l>",
                'copilot#Accept("<CR>")',
                { expr = true, noremap = true, silent = true, replace_keycodes = false, desc = "copilot autocomplete" }
            )
            vim.keymap.set("n", "<leader>a", ":CopilotChatToggle<CR>", { desc = "copilot chat" })
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",
        opts = {
            -- model = "o4-mini",
            model = "claude-3.7-sonnet",
            mappings = {
                reset = {
                    normal = "",
                    insert = "",
                },
            },
        },
    },
}
