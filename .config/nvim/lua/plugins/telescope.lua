return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
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
            local builtin = require('telescope.builtin')
            local live_grep_args = require("telescope").load_extension "live_grep_args"

            -- file pickers
            vim.keymap.set('n', '<C-f>f', builtin.find_files,           {desc= "find files"})
            vim.keymap.set('n', '<C-f>F', builtin.git_files,            {desc= "find files respect .gitignore"})

            vim.keymap.set('n', '<C-f>g', live_grep_args.live_grep_raw, {desc= "live rip grep"}) -- live ripgrep (accepts args)
            vim.keymap.set('n', '<C-f>G', builtin.resume,               {desc= "resume"})
            vim.keymap.set('n', '<C-f>c', builtin.commands,             {desc= "commands"})

            vim.keymap.set('n', '<C-f>b', builtin.buffers,              {desc= "buffers"})
            vim.keymap.set('n', '<C-f>B', builtin.oldfiles,             {desc= "old files"})

            vim.keymap.set('n', '<C-f>q', builtin.quickfix,             {desc= "quickfix"})
            vim.keymap.set('n', '<C-f>m', builtin.marks,                {desc= "marks"})
            vim.keymap.set('n', '<C-f>h', builtin.marks,                {desc= "marks"})
            vim.keymap.set('n', '<C-f>y', builtin.registers,            {desc= "registers"})
            vim.keymap.set('n', '<C-f>z', builtin.spell_suggest,        {desc= "spell_suggest"})

            -- lsp pickers
            vim.keymap.set('n', '<C-f>w', builtin.lsp_document_symbols, {desc= "doc symbols"})      -- LSP document symbols in the current buffer
            vim.keymap.set('n', '<C-f>W', builtin.lsp_workspace_symbols,{desc= "ws symbols"})       -- LSP document symbols in the current workspace
            vim.keymap.set('n', '<C-f>D', builtin.diagnostics,          {desc= "all diagnostics"})  -- Diagnostics for all open buffers or specific buffer. Use bufnr=0 for current buffer.
            vim.keymap.set('n', '<C-f>t', builtin.treesitter,           {desc= "treesitter symbols"})   -- Function names, variables, from Treesitter!
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
                            ["<leader>l"] = actions.file_vsplit,
                            ["<leader>j"] = actions.file_split,

                            ["<C-n>"] = actions.move_selection_next,
                            ["<C-p>"] = actions.move_selection_previous,

                            ["<leader>m"] = actions.toggle_selection + actions.move_selection_worse,
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
