------ Telescope + Fzf
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
require('telescope').setup {
    defaults = {
        mappings = {
            -- Mapping <Esc> to quit in insert mode If you'd prefer Telescope not to enter a normal-like mode when hitting escape (and instead exiting), you can map <Esc> to do so via:
            i = {["<esc>"] = actions.close, ["<C-q>"] = actions.close},
            n = {
                -- toggle the preview
                ["<M-p>"] = action_layout.toggle_preview,
                ["<M-p>"] = action_layout.toggle_preview
            }
        },
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
            "--smart-case"
            -- "--trim" -- remove indentation
        },
        prompt_prefix = " > ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {prompt_position = "top", preview_width = 0.55, results_width = 0.8},
            vertical = {mirror = false},
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {"node_modules"},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = {"truncate"},
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
    },
    pickers = {find_files = {theme = "dropdown"}},
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}

-- load extension after setup to get fzf loaded and working with telescope
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

-- FILES
nnoremap('<C-f>f', "<cmd>lua require('telescope.builtin').find_files()<cr>") -- live fd (respects .gitignore)
-- nnoremap('<C-f>g', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nnoremap('<C-f>g', "<cmd>lua require('telescope').extensions.live_grep_raw.live_grep_raw()<cr>") -- live rg (accepts args)
-- nnoremap('<C-f>x', "<cmd>lua require('telescope.builtin').grep_string()<cr>") -- live rip grep on string under cursor
-- nnoremap('<C-f>y', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>") -- Live fuzzy search inside of the currently open buffer

-- VIM
nnoremap('<C-f>b', "<cmd>lua require('telescope.builtin').buffers()<cr>")
nnoremap('<C-f>q', "<cmd>lua require('telescope.builtin').quickfix()<cr>")
nnoremap('<C-f>r', "<cmd>lua require('telescope.builtin').oldfiles()<cr>")
nnoremap('<C-f>p', "<cmd>lua require('telescope.builtin').commands()<cr>")

-- nnoremap('<C-f>j', "<cmd>lua require('telescope.builtin').jumplist()<cr>")
nnoremap('<C-f>m', "<cmd>lua require('telescope.builtin').marks()<cr>")
nnoremap('<C-f>y', "<cmd>lua require('telescope.builtin').registers()<cr>")
-- nnoremap('<C-f>h', "<cmd>lua require('telescope.builtin').help_tags()<cr>")
nnoremap('<C-f>s', "<cmd>lua require('telescope.builtin').spell_suggest()<cr>") -- spelling suggestions for the current word under the cursor, replaces word with selected suggestion o

-- LSP
-- nnoremap('<C-f>H', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>") -- LSP document symbols in the current buffer
nnoremap('<C-f>H', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>") -- LSP document symbols in the current workspace
-- nnoremap('<C-f>fs', "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>")  -- Dynamically Lists LSP for all workspace symbols

nnoremap('<C-f>k', "<cmd>lua require('telescope.builtin').lsp_references()<cr>") -- LSP references for word under the cursor
nnoremap('<C-f>a', "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>") -- any LSP actions for the word under the cursor, trigger with <cr>
nnoremap('<C-f>d', "<cmd>lua require('telescope.builtin').diagnostics()<cr>") -- Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
nnoremap('<C-f>e', "<cmd>lua require('telescope.builtin').treesitter()<cr>")       -- Function names, variables, from Treesitter!

-- GIT
-- nnoremap('<C-f>fc', "<cmd>lua require('telescope.builtin').git_commits()<cr>")      -- git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h
-- nnoremap('<C-f>fc', "<cmd>lua require('telescope.builtin').git_bcommits()<cr>")     -- buffer's git commits with diff preview and checks them out on <cr>
-- nnoremap('<C-f>fc', "<cmd>lua require('telescope.builtin').git_branches()<cr>")     -- all branches with log preview, checkout action <cr>, track action <C-t> and rebase action<C-r>

