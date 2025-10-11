vim.pack.add { { src = "https://github.com/nvim-tree/nvim-tree.lua" } }

local F = {}
function F.on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts "CD")
    vim.keymap.set("n", "o", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "O", api.node.navigate.parent_close, opts "Close Directory")
    vim.keymap.set("n", "<leader>\\", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.set("n", "<leader>|", api.node.open.horizontal, opts "Open: Horizontal Split")
    vim.keymap.set("n", "r", api.fs.rename, opts "Rename")
    vim.keymap.set("n", "c", api.fs.create, opts "Create")
    vim.keymap.set("n", "d", api.fs.cut, opts "Cut")
    vim.keymap.set("n", "D", api.fs.remove, opts "Delete")
    vim.keymap.set("n", "y", api.fs.copy.node, opts "Copy")
    vim.keymap.set("n", "p", api.fs.paste, opts "Paste")
    vim.keymap.set("n", "f", api.live_filter.start, opts "Filter")
    vim.keymap.set("n", "<BS>", api.live_filter.clear, opts "Clean Filter")
    vim.keymap.set("n", "R", api.tree.reload, opts "Refresh")
    vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts "Toggle Dotfiles")
    vim.keymap.set("n", "z", api.tree.toggle_gitignore_filter, opts "Toggle Git Ignore")
    vim.keymap.set("n", "m", api.marks.toggle, opts "Toggle Bookmark")
    vim.keymap.set("n", "q", api.tree.close, opts "Close")
    vim.keymap.set("n", "?", api.tree.toggle_help, opts "Help")
end

-- Setup keymap
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<cr>")

-- Setup nvim-tree
require("nvim-tree").setup {
    on_attach = F.on_attach,
    disable_netrw = true,
    view = { width = 25 },
    renderer = {
        icons = {
            padding = "",
            symlink_arrow = " ➜ ",
            show = { folder_arrow = false },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = ">",
                modified = "*",
                git = {
                    unstaged = "'",
                    staged = "'",
                    unmerged = "'",
                    renamed = "'",
                    untracked = "",
                    deleted = "",
                    ignored = "",
                },
                folder = {
                    default = "◼ ",
                    open = "┌ ",
                    empty = "□ ",
                    empty_open = "□ ",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
        indent_markers = {
            enable = true,
            icons = { corner = "└ ", edge = "│ ", item = "│ ", none = "  " },
        },
    },
    update_focused_file = { enable = true },
    actions = {
        change_dir = { global = true }
    },
    git = { timeout = 500 },
    live_filter = { prefix = "> " },
}
