------ FZF TELESCOPE

local telescope = require('telescope')
local actions = require("telescope.actions")

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<leader>q"] = actions.close,
                ["<leader>x"] = actions.close,
                ["<leader>l"] = actions.file_vsplit,
                ["<leader>j"] = actions.file_split,
            },
        },
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
            "--smart-case"
            -- "--trim" -- remove indentation
        },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {prompt_position = "top", preview_width = 0.55, results_width = 0.8},
            vertical = {mirror = false},
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120
        },
        path_display = {"truncate"},
        border = {},
        borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        use_less = true,
    },
}

-- load extension after setup
telescope.load_extension('fzf')
telescope.load_extension('live_grep_args')
telescope.load_extension("ui-select")


local builtin = require('telescope.builtin')

-- FILES
vim.keymap.set('n', '<C-f>f', builtin.find_files, {})
vim.keymap.set('n', '<C-f>g', telescope.extensions.live_grep_args.live_grep_raw, {}) -- live rg (accepts args)

-- VIM
vim.keymap.set('n', '<C-f>b', builtin.buffers, {})
vim.keymap.set('n', '<C-f>q', builtin.quickfix, {})
vim.keymap.set('n', '<C-f>e', builtin.oldfiles, {})
vim.keymap.set('n', '<C-f>m', builtin.marks, {})
vim.keymap.set('n', '<C-f>y', builtin.registers, {})
vim.keymap.set('n', '<C-f>z', builtin.spell_suggest, {})
vim.keymap.set('n', '<C-f>c', builtin.commands, {})

-- LSP
vim.keymap.set('n', '<C-f>w', builtin.lsp_document_symbols, {})     -- LSP document symbols in the current buffer
vim.keymap.set('n', '<C-f>W', builtin.lsp_workspace_symbols, {})    -- LSP document symbols in the current workspace
vim.keymap.set('n', '<C-f>k', builtin.lsp_references, {})           -- LSP references for word under the cursor
-- vim.keymap.set('n', '<C-f>d', builtin.diagnostics, {})              -- Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
vim.keymap.set('n', '<C-f>t', builtin.treesitter, {})               -- Function names, variables, from Treesitter!
