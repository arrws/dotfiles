return {
    {
        "github/copilot.vim",
        lazy = false,
        config = function ()
            vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', { expr=true, noremap=true, silent=true, desc="copilot autocomplete" })
        end,
    },
}
