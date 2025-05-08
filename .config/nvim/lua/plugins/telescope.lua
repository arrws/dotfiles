---@diagnostic disable: undefined-global

return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                enabled = vim.fn.executable "make" == 1,
                config = function()
                    require("telescope").load_extension "fzf"
                end,
            },
            {
                "nvim-telescope/telescope-live-grep-args.nvim",
                config = function()
                    require("telescope").load_extension "live_grep_args"
                end,
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
                config = function()
                    require("telescope").load_extension "ui-select"
                end,
            },
        },

        init = function()
            local builtin = require "telescope.builtin"
            local live_grep_args = require("telescope").load_extension "live_grep_args"

            vim.keymap.set("n", "<leader>o", builtin.resume, { desc = "resume" })

            -- file pickers
            vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "files" })
            vim.keymap.set("n", "<leader>F", builtin.oldfiles, { desc = "old files" })
            vim.keymap.set("n", "<leader>g", live_grep_args.live_grep_raw, { desc = "live rip grep" }) -- live ripgrep (accepts args)
            vim.keymap.set("n", "<leader>G", builtin.git_files, { desc = "files respecting .gitignore" })

            -- nvim pickers
            vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "buffers" })
            vim.keymap.set("n", "<leader>x", builtin.quickfix, { desc = "quickfix" })
            vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "marks" })
            vim.keymap.set("n", "<leader>y", builtin.registers, { desc = "registers" })

            -- help pickers
            vim.keymap.set("n", "<leader>hz", builtin.spell_suggest, { desc = "spell_suggest" })
            vim.keymap.set("n", "<leader>hk", builtin.keymaps, { desc = "keymaps" })
            vim.keymap.set("n", "<leader>hc", builtin.commands, { desc = "commands" })
            vim.keymap.set("n", "<leader>hm", builtin.man_pages, { desc = "man_pages" })

            -- lsp pickers
            vim.keymap.set("n", "<leader>t", builtin.treesitter, { desc = "treesitter symbols" })
            vim.keymap.set("n", "<leader>T", builtin.lsp_document_symbols, { desc = "buffer symbols" })
            vim.keymap.set("n", "<leader>i", builtin.lsp_implementations, { desc = "implementations" })
            vim.keymap.set("n", "<leader>r", builtin.lsp_references, { desc = "references" })
            vim.keymap.set("n", "<leader>D", builtin.diagnostics, { desc = "diagnostics" })
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "line diagnostic" })
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "code action" })
            -- vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, { desc = "go to definition" })
            vim.keymap.set("n", "K", vim.lsp.buf.definition, { desc = "go to definition" })
            -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.declaration, { desc = "go to declaration" })
            vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, { desc = "go to implementation" })
            vim.keymap.set("n", "<leader>t", vim.lsp.buf.type_definition, { desc = "go to type definition" })
            vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "hover" })
            vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, { desc = "signature help" })

            -- git pickers
            vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "git status" })
            vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "git stash" })
            vim.keymap.set("n", "<leader>gc", builtin.git_bcommits, { desc = "git buffer commits" })
            vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "git commits" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "git branches" })
        end,

        opts = function()
            local actions = require "telescope.actions"

            return {
                defaults = {
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<leader>q"] = actions.close,

                            ["<CR>"] = actions.select_default,
                            ["<C-j>"] = actions.select_default,
                            ["<leader>s"] = actions.file_vsplit,
                            ["<leader>S"] = actions.file_split,

                            ["<C-n>"] = actions.move_selection_next,
                            ["<C-p>"] = actions.move_selection_previous,

                            ["<C-t>"] = actions.toggle_selection + actions.move_selection_worse,
                            ["<leader>q"] = actions.send_selected_to_qflist,

                            ["<C-u>"] = actions.preview_scrolling_up,
                            ["<C-d>"] = actions.preview_scrolling_down,
                            ["<C-x>"] = actions.delete_buffer,
                        },
                        n = {
                            ["q"] = actions.close,
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        -- "--trim" -- remove indentation
                    },
                    layout_strategy = "horizontal",
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
                        vertical = { mirror = false },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    path_display = { "truncate" },
                    border = {},
                    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                    use_less = true,
                },
            }
        end,
    },
}
