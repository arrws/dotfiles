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

    vim.api.nvim_set_hl(0, "IndentLine",            { fg = c.gray_deep })
    vim.api.nvim_set_hl(0, "IndentLineCurrent",     { fg = c.gray_dark })

    vim.api.nvim_set_hl(0, "NormalFloat",           { link = "Normal" }) -- normal text in floating windows
    vim.api.nvim_set_hl(0, "FloatBorder",           { fg = c.gray_deeper, bg = c.black }) -- floating window border

    vim.api.nvim_set_hl(0, "TelescopeBorder",       { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "TelescopeNormal",       { link = "Normal" })
    vim.api.nvim_set_hl(0, "TelescopeMatching",     { link = "WildMenu" })
    vim.api.nvim_set_hl(0, "TelescopeSelection",    { link = "WildMenu" })

    vim.api.nvim_set_hl(0, "WildMenu",              { fg = c.green_bright, bg = c.green_dark }) -- active
    vim.api.nvim_set_hl(0, "StatusLine",            { fg = c.white_soft }) -- inactive
    vim.api.nvim_set_hl(0, "StatusLineNC",          { fg = c.black }) -- not-current windows

    vim.api.nvim_set_hl(0, "TabLine",               { link = "StatusLine" }) -- inactive tab text
    vim.api.nvim_set_hl(0, "TabLineSel",            { link = "WildMenu" }) -- active tab text
    vim.api.nvim_set_hl(0, "TabLineFill",           { bg = c.black })

    vim.api.nvim_set_hl(0, "PMenuSel",              { link = "WildMenu" }) -- selected item.
    vim.api.nvim_set_hl(0, "PMenu",                 { link = "StatusLine" }) -- normal item.
    vim.api.nvim_set_hl(0, "PMenuKind",             { fg = c.gray_soft })
    vim.api.nvim_set_hl(0, "PMenuExtra",            { link = "PMenuKind" })
    vim.api.nvim_set_hl(0, "PMenuThumb",            { link = "StatusLine" }) -- Thumb of the scrollbar.

    vim.api.nvim_set_hl(0, "Search",                { link = "WildMenu" }) -- all other search matches
    vim.api.nvim_set_hl(0, "CurSearch",             { link = "TelescopeMatching"  })

    vim.api.nvim_set_hl(0, "MiniJump2dSpot",        { link = "TelescopeMatching" }) -- easymotion
    vim.api.nvim_set_hl(0, "MiniJump",              { link = "TelescopeMatching" }) -- f replacement

    vim.api.nvim_set_hl(0, "NvimTreeRootFolder",    { fg = c.gray_light, bold = true })
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon",    { fg = c.gray_dark })
    vim.api.nvim_set_hl(0, "Directory",             { fg = c.amber_dark })
    vim.api.nvim_set_hl(0, "NvimTreeFolderName",     { link = "Directory" })
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { link = "Directory" })

    vim.api.nvim_set_hl(0, "Added",                  { fg = c.green })
    vim.api.nvim_set_hl(0, "Changed",                { fg = c.green })
    vim.api.nvim_set_hl(0, "Removed",                { fg = c.red })


    -- CODING

    local syntax = {
        Comment =              { fg = c.slate_warm, italic = true },
        Constant =             { fg = c.amber_white },
        String =               { fg = c.teal, italic = true },
        Character =            { link = "String" },
        Number =               { fg = c.teal_light, italic = true },
        Boolean =              { fg = c.teal_dark, italic = true },
        pythonBoolean =        { link = "Boolean" },

        Identifier =           { fg = c.off_white },
        Function =             { fg = c.off_blue },
        Method =               { link = "Function" },
        Property =             { link = "Identifier" },
        Field =                { link = "Property" },
        Parameter =            { link = "Constant" },

        Keyword =              { fg = c.off_gray },
        Operator =             { link = "Keyword" },
        Statement =            { link = "Keyword" },
        Label =                { link = "Identifier" },

        PreProc =              { link = "Keyword" },
        Include =              { link = "Attribute" },
        Define =               { fg = c.amber_light },
        Macro =                { link = "Define" },
        Type =                 { fg = c.amber_light, italic = true },
        Class =                { fg = c.amber, italic = true },

        Attribute =            { fg = c.slate_cool },
        pythonDecorator =      { fg = c.slate_warm },
        pythonDecoratorName =  { link = "pythonDecorator" },
        Special =              { link = "Attribute" },
        SpecialChar =          { link = "Define" },
        Tag =                  { link = "Define" },
        Delimiter =            { link = "Attribute" },
        Todo =                 { fg = c.amber_light, bold = true },

        ["@punctuation.bracket"] =      { link = "Keyword" },
        ["@punctuation.separator"] =    { link = "Keyword" },
        ["@constant.builtin"] =         { link = "Constant" },
        ["@constant.builtin.python"] =  { link = "Boolean" },
        ["@constant.macro"] =           { link = "Define" },
        ["@string.special"] =           { link = "Boolean" },
        ["@string.special.url"] =       { link = "String" },
        ["@function.builtin"] =         { link = "Function" },
        ["@function.macro"] =           { link = "Define" },
        ["@variable"] =                 { link = "Parameter" },
        ["@variable.builtin"] =         { link = "@variable" },
        ["@variable.builtin.python"] =  { link = "@variable.parameter" },
        ["@variable.parameter"] =       { link = "Parameter" },
        ["@property"] =                 { link = "Define" },
        ["@constructor"] =              { link = "@type" },
        ["@keyword.import"] =           { link = "Include" },
        ["@type"] =                     { link = "Class" },
        ["@type.builtin"] =             { link = "Type" },
        ["@type.definition"] =          { link = "Type" },
        ["@module"] =                   { fg = c.off_white, italic = true },
        ["@attribute"] =                { link = "Attribute" },
        ["@tag.builtin"] =              { link = "Tag" },
        ["@tag.delimiter"] =            { link = "Keyword" },
        ["@tag.attribute"] =            { link = "Keyword" },
        ["@string.special.path"] =      { link = "String" },
        ["@markup.link.url"] =          { link = "String" },
        ["@markup.raw"] =               { link = "Property" },
        ["@markup.heading"] =           { link = "Keyword" },

        ["@lsp.type.typeParameter"] =   { link = "@variable.parameter" },
        ["@lsp.type.property"] =        { link = "@variable" },
        ["@lsp.type.method"] =          { link = "@function" },
    }

    for group, highlight in pairs(syntax) do
        vim.api.nvim_set_hl(0, group, highlight)
    end

end

return M
