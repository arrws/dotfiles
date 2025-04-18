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
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            model = "gpt-o3-mini", -- Default model, see ':CopilotChatModels'
            clear_chat_on_new_prompt = false,
            mappings = {
                reset = {
                    normal = "",
                    insert = "",
                },
            },
        },
    },
}
