------ Tree View

nnoremap('<leader>n', ':NvimTreeToggle<CR>')
nnoremap('<leader>m', ':lua MiniMap.toggle()<CR>')

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    diagnostics = {enable = false, icons = {hint = "H", info = "I", warning = "W", error = "E"}},
    renderer = {
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = "",
            symlink_arrow = " > ",
            show = {git = true, folder = true, folder_arrow = false, file = true},
            glyphs = {
                default = "",
                symlink = "~",
                git = {
                    unstaged = "",
                    staged = "*",
                    unmerged = "",
                    renamed = "*",
                    untracked = "*"
                },
                folder = {
                    default = "◼ ",
                    open = "┌ ",
                    empty = "□ ",
                    empty_open = "□ ",
                    symlink = "~",
                    symlink_open = "~",
                }
            }
        },
        indent_markers = {
            enable = true,
            icons = {corner = "└ ", edge = "│ ", item = "│ ", none = "  "}
        }
    },
    update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
    system_open = {cmd = nil, args = {}},
    filters = {dotfiles = false, custom = {}},
    git = {enable = true, ignore = true, timeout = 500},
    view = {
        width = 25,
        hide_root_folder = false,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
                {key = "<CR>", action = "edit"},
                {key = "o", action = "edit"},
                {key = "<C-CR>", action = "cd"},
                {key = "<C-BS>", action = "dir_up"},
                {key = "<leader>l", action = "vsplit"},
                {key = "<leader>j", action = "split"},
                {key = "<BS>", action = "close_node"},
                {key = "z", action = "toggle_ignored"},
                {key = ".", action = "toggle_dotfiles"},
                {key = "R", action = "refresh"},
                {key = "c", action = "create"},
                {key = "D", action = "remove"},
                {key = "r", action = "rename"},
                {key = "d", action = "cut"},
                {key = "y", action = "copy"},
                {key = "p", action = "paste"},
                {key = "q", action = "close"},
                {key = "x", action = "close"},
                {key = "<C-m>", action = "close"}
            }
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes"
    },
    trash = {cmd = "trash", require_confirm = true}
})
