---@diagnostic disable: undefined-global

local F = {}
function F.on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,               opts('Open'))
    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node,     opts('CD'))
    vim.keymap.set('n', '<CR>',           api.tree.change_root_to_node,     opts('CD'))
    vim.keymap.set('n', 'o',              api.node.open.edit,               opts('Open'))
    vim.keymap.set('n', 'O',              api.node.navigate.parent_close,   opts('Close Directory'))
    vim.keymap.set('n', '<leader>l',      api.node.open.vertical,           opts('Open: Vertical Split'))
    vim.keymap.set('n', '<leader>j',      api.node.open.horizontal,         opts('Open: Horizontal Split'))
    vim.keymap.set('n', 'r',              api.fs.rename,                    opts('Rename'))
    vim.keymap.set('n', 'c',              api.fs.create,                    opts('Create'))
    vim.keymap.set('n', 'd',              api.fs.cut,                       opts('Cut'))
    vim.keymap.set('n', 'D',              api.fs.remove,                    opts('Delete'))
    vim.keymap.set('n', 'y',              api.fs.copy.node,                 opts('Copy'))
    vim.keymap.set('n', 'p',              api.fs.paste,                     opts('Paste'))
    vim.keymap.set('n', 'f',              api.live_filter.start,            opts('Filter'))
    vim.keymap.set('n', '<BS>',           api.live_filter.clear,            opts('Clean Filter'))
    vim.keymap.set('n', 'R',              api.tree.reload,                  opts('Refresh'))
    vim.keymap.set('n', '.',              api.tree.toggle_hidden_filter,    opts('Toggle Dotfiles'))
    vim.keymap.set('n', 'z',              api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    vim.keymap.set('n', 'm',              api.marks.toggle,                 opts('Toggle Bookmark'))
    vim.keymap.set('n', 'q',              api.tree.close,                   opts('Close'))
    vim.keymap.set('n', '?',              api.tree.toggle_help,             opts('Help'))
end

return {
    {
        "nvim-tree/nvim-tree.lua",

        init = function()
            vim.keymap.set('n', "<leader>n", ":NvimTreeToggle<cr>")
        end,

        opts = {
            on_attach = F.on_attach,
            disable_netrw = true,
            sync_root_with_cwd = false,
            view = {
                width = 25,
                -- hide_root_folder = false,
                side = "left",
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                -- mappings = {custom_only = true}
            },
            renderer = {
                icons = {
                    webdev_colors = true,
                    git_placement = "before",
                    modified_placement = "after",
                    padding = "",
                    symlink_arrow = " ➜ ",
                    show = {
                        git = true,
                        folder = true,
                        folder_arrow = false,
                        file = true,
                    },
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
            update_focused_file = { enable = true, update_root = false, ignore_list = {} },
            system_open = { cmd = nil, args = {} },
            filters = {
                dotfiles = false,
                no_buffer = false,
                custom = {},
                exclude = {},
            },
            actions = {
                use_system_clipboard = true,
                change_dir = {
                    enable = true,
                    global = true,
                    restrict_above_cwd = false,
                },
            },
            git = {
                enable = true,
                ignore = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
                timeout = 500,
            },
            live_filter = { prefix = "> ", always_show_folders = true },
        },
    },
}
