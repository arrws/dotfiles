------ Tree View
nnoremap('<C-e>m', ':NvimTreeToggle<CR>')

vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "~",
    git = {
        unstaged = "×",
        staged = "➜",
        unmerged = "",
        renamed = "×",
        untracked = "×"
    },
    folder = {
        default = "◼",
        open = "┌",
        empty = "-",
        empty_open = "-",
        symlink = "~"
    }
}

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    -- auto_close = false,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    -- update_to_buf_dir = {
    --     enable = true,
    --     auto_open = true,
    -- },
    diagnostics = {
        enable = false,
        icons = {hint = "", info = "I", warning = "W", error = "E"}
    },
    update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
    system_open = {cmd = nil, args = {}},
    filters = {dotfiles = false, custom = {}},
    git = {enable = true, ignore = true, timeout = 500},
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        -- auto_resize = false,
        mappings = {
            custom_only = false,
            list = {
                {key = "<CR>", action = "edit"}, {key = "o", action = "edit"},
                {key = "<C-CR>", action = "cd"},
                {key = "<C-BS>", action = "dir_up"},
                {key = "<C-s>l", action = "vsplit"},
                {key = "<C-s>j", action = "split"},
                -- { key = "<C-t>",         action = "tabnew" },
                {key = "<BS>", action = "close_node"},
                {key = "z", action = "toggle_ignored"},
                {key = ".", action = "toggle_dotfiles"},
                {key = "R", action = "refresh"}, {key = "c", action = "create"},
                {key = "D", action = "remove"}, {key = "r", action = "rename"},
                {key = "d", action = "cut"}, {key = "y", action = "copy"},
                {key = "p", action = "paste"}, {key = "q", action = "close"},
                {key = "<C-e>", action = "close"},
            }
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes"
    },
    trash = {cmd = "trash", require_confirm = true}
})
