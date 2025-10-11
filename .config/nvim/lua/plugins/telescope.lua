vim.pack.add {
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
}

-- Setup telescope when first command is run
local telescope_setup = false
local function setup_telescope()
    if telescope_setup then
        return
    end
    telescope_setup = true

    local actions = require "telescope.actions"

    require("telescope").setup {
        defaults = {
            mappings = {
                i = {
                    -- C-q quickfix C-n C-p
                    ["<esc>"] = actions.close,
                    ["<leader>q"] = actions.close,
                    ["<C-j>"] = actions.select_default, -- Enter
                    ["<leader>//"] = actions.file_vsplit,
                    ["<leader>|"] = actions.file_split,
                    ["<C-t>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<C-x>"] = actions.delete_buffer,
                },
                n = {
                    ["q"] = actions.close,
                },
            },
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 },
                vertical = { mirror = false },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            path_display = { "truncate" },
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
    }

    -- Load extensions
    if vim.fn.executable "make" == 1 then
        -- Build fzf-native if needed (support Linux/macOS artifacts)
        local fzf_path = vim.fn.stdpath "data" .. "/site/pack/packages/start/telescope-fzf-native.nvim"
        if vim.fn.isdirectory(fzf_path) == 1 then
            local so = fzf_path .. "/build/libfzf.so"
            local dylib = fzf_path .. "/build/libfzf.dylib"
            if vim.fn.filereadable(so) == 0 and vim.fn.filereadable(dylib) == 0 then
                vim.fn.system("cd " .. fzf_path .. " && make")
            end
        end
        require("telescope").load_extension "fzf"
    end

    require("telescope").load_extension "live_grep_args"
    require("telescope").load_extension "ui-select"
end

-- Create Telescope command that triggers setup
-- Use a custom wrapper instead of shadowing Telescope's own command
vim.api.nvim_create_user_command("TT", function(opts)
    setup_telescope()
    require("telescope.builtin")[opts.args]()
end, {
    nargs = 1,
    complete = function()
        return vim.tbl_keys(require "telescope.builtin")
    end,
})

-- Setup keymaps (lazy-loaded)
local function t_map(key, picker, desc, use_extension)
    vim.keymap.set("n", key, function()
        setup_telescope()
        if use_extension then
            require("telescope").extensions[use_extension][picker]()
        else
            require("telescope.builtin")[picker]()
        end
    end, { desc = desc })
end

-- Resume
t_map("<leader>o", "resume", "resume")

-- File pickers
t_map("<leader>f", "find_files", "files")
t_map("<leader>F", "oldfiles", "old files")
vim.keymap.set("n", "<leader>r", function()
    setup_telescope()
    require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "live rip grep" })
t_map("<leader>R", "git_files", "files respecting .gitignore")

-- Nvim pickers
t_map("<leader>b", "buffers", "buffers")
t_map("<leader>x", "quickfix", "quickfix")
t_map("<leader>m", "marks", "marks")
t_map("<leader>y", "registers", "registers")

-- Help pickers
t_map("<leader>hz", "spell_suggest", "spell_suggest")
t_map("<leader>hk", "keymaps", "keymaps")
t_map("<leader>hc", "commands", "commands")
t_map("<leader>hm", "man_pages", "man_pages")

-- LSP pickers
-- t_map("<leader>t", "treesitter", "treesitter symbols")
-- t_map("<leader>T", "lsp_document_symbols", "buffer symbols")
t_map("<leader>i", "lsp_implementations", "implementations")
-- t_map("<leader>r", "lsp_references", "references")
t_map("<leader>D", "diagnostics", "diagnostics")

-- LSP keymaps (not telescope)
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "line diagnostic" })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "code action" })
vim.keymap.set("n", "<leader>T", vim.lsp.buf.type_definition, { desc = "go to type definition" })

-- Git pickers
t_map("<leader>gs", "git_status", "git status")
t_map("<leader>gS", "git_stash", "git stash")
t_map("<leader>gc", "git_bcommits", "git buffer commits")
t_map("<leader>gC", "git_commits", "git commits")
t_map("<leader>gb", "git_branches", "git branches")
