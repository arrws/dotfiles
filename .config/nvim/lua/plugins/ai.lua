return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("codecompanion").setup {
                strategies = {
                    chat = {
                        adapter = "openai",
                    },
                    inline = {
                        adapter = "copilot",
                    },
                },
                adapters = {
                    opts = {
                        allow_insecure = true,
                        proxy = "socks5://10.8.0.1:1080",
                    },
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            env = {
                                api_key = "",
                            },
                        })
                    end,
                },
            }
        end,
    },
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
}
