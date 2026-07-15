local c = require "colors"
local M = {}

function M.load()
    -- Reset existing highlights
    vim.cmd "hi clear"
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd "syntax reset"
    end

    vim.o.background = "dark"

    -- builtin
    vim.api.nvim_set_hl(0, "Normal",                { fg = c.gray_light, bg = c.black }) -- normal text
    vim.api.nvim_set_hl(0, "NormalNC",              { fg = c.gray_soft, bg = c.black }) -- normal text in non-current windows

    vim.api.nvim_set_hl(0, "WinSeparator",          { fg = c.black }) -- vertical bar splitting windows
    vim.api.nvim_set_hl(0, "VertSplit",             { link = "WinSeparator" })

    vim.api.nvim_set_hl(0, "IndentLine",            { fg = c.gray_deep })
    vim.api.nvim_set_hl(0, "IndentLineCurrent",     { fg = c.gray_dark })

    vim.api.nvim_set_hl(0, "NormalFloat",           { fg = c.gray_light, bg = c.black }) -- normal text in floating windows
    vim.api.nvim_set_hl(0, "FloatBorder",           { fg = c.gray_deeper, bg = c.black }) -- floating window border

    vim.api.nvim_set_hl(0, "TelescopeBorder",       { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopeNormal",       { link = "Normal" })
    vim.api.nvim_set_hl(0, "TelescopeMatching",     { fg = c.green_bright, bg = c.green_dark })
    vim.api.nvim_set_hl(0, "TelescopeSelection",    { link = "WildMenu" })

    vim.api.nvim_set_hl(0, "WildMenu",              { fg = c.green_bright, bg = c.green_dark }) -- active
    vim.api.nvim_set_hl(0, "StatusLine",            { fg = c.white_soft }) -- inactive
    vim.api.nvim_set_hl(0, "StatusLineNC",          { fg = c.black }) -- not-current windows
    vim.api.nvim_set_hl(0, "StatusLineTerm",        { link = "StatusLine" })
    vim.api.nvim_set_hl(0, "StatusLineTermNC",      { link = "StatusLineNC" })

    vim.api.nvim_set_hl(0, "TabLine",               { link = "StatusLine" }) -- inactive tab text
    vim.api.nvim_set_hl(0, "TabLineSel",            { link = "WildMenu" }) -- active tab text
    vim.api.nvim_set_hl(0, "TabLineFill",           { bg = c.black })

    vim.api.nvim_set_hl(0, "PMenuSel",              { link = "WildMenu" }) -- selected item.
    vim.api.nvim_set_hl(0, "PMenu",                 { link = "StatusLine" }) -- normal item.
    vim.api.nvim_set_hl(0, "PMenuKind",             { fg = c.grey_soft })
    vim.api.nvim_set_hl(0, "PMenuExtra",            { fg = c.grey_soft })
    vim.api.nvim_set_hl(0, "PMenuSbar",             { link = "StatusLine" }) -- scrollbar.
    vim.api.nvim_set_hl(0, "PMenuThumb",            { link = "StatusLine" }) -- Thumb of the scrollbar.

    vim.api.nvim_set_hl(0, "IncSearch",             { link = "TelescopeMatching" }) -- current / search match
    vim.api.nvim_set_hl(0, "Search",                { fg = c.green_bright, bg = c.green_dark }) -- all other search matches
    vim.api.nvim_set_hl(0, "CurSearch",             { link = "TelescopeMatching"  })
    vim.api.nvim_set_hl(0, "Substitute",            { fg = c.green_bright, bg = c.green_dark }) -- :substitute matches

    vim.api.nvim_set_hl(0, "MiniJump2dSpot",        { link = "TelescopeMatching" }) -- easymotion
    vim.api.nvim_set_hl(0, "MiniJump",              { link = "TelescopeMatching" }) -- f replacement

    vim.api.nvim_set_hl(0, "NvimTreeRootFolder",    { fg = c.gray_light, bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon",    { fg = c.gray_dark })


    -- coding
    vim.api.nvim_set_hl(0, "Boolean",               { fg = c.t_green }) -- boolean constant: TRUE, false
    vim.api.nvim_set_hl(0, "Number",                { fg = c.t_green }) -- number constant: 234, 0xff
    vim.api.nvim_set_hl(0, "Float",                 { link = "Number"  }) -- floating-point constant: 2.3e10
    -- vim.api.nvim_set_hl(0, "Special",               { fg = c.white_light }) -- any special symbol - python self and @
    vim.api.nvim_set_hl(0, "Keyword",               { fg = c.gray_light  }) -- any other keyword
    vim.api.nvim_set_hl(0, "Operator",              { fg = c.gray_soft }) -- sizeof, +, *, etc.
    vim.api.nvim_set_hl(0, "Type",                  { fg = c.blue_white }) -- int, long, char, etc.
    -- vim.api.nvim_set_hl(0, "Function",              { fg = c.amber_pale }) -- function and method names

end

return M
