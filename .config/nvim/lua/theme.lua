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
    vim.api.nvim_set_hl(0, "PMenuKind",             { fg = c.gray_soft })
    vim.api.nvim_set_hl(0, "PMenuExtra",            { fg = c.gray_soft })
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
    vim.api.nvim_set_hl(0, "Directory",             { fg = c.t_purple })
    vim.api.nvim_set_hl(0, "NvimTreeFolderName",     { fg = c.t_purple })
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.t_purple })


    -- coding: Vesper syntax palette
    local syntax = {
        Comment =              { fg = c.slate_warm, italic = true },
        Constant =             { fg = c.amber_white },
        String =               { fg = c.teal, italic = true },
        Character =            { fg = c.teal, italic = true },
        Number =               { fg = c.teal_light, italic = true },
        Boolean =              { fg = c.teal_dark, italic = true },
        Float =                { link = "Number" },
        pythonBoolean =        { link = "Boolean" },

        Identifier =           { fg = c.off_white },
        Function =             { fg = c.off_blue },
        Method =               { link = "Function" },
        Property =             { fg = c.off_white },
        Field =                { link = "Property" },
        Parameter =            { fg = c.amber_white },

        Conditional =          { fg = c.off_gray  },
        Repeat =               { fg = c.off_gray   },
        Operator =             { fg = c.off_gray },
        Keyword =              { fg = c.off_gray },
        Statement =            { fg = c.off_gray },
        Exception =            { fg = c.off_gray },
        Label =                { fg = c.off_white },

        PreProc =              { link = "Keyword" },
        Include =              { link = "Attribute" },
        Define =               { fg = c.amber_light },
        Macro =                { link = "Define" },
        PreCondit =            { fg = c.off_gray },
        Type =                 { fg = c.off_white, italic = true },
        StorageClass =         { link = "Type" },
        Structure =            { link = "Type" },
        Typedef =              { link = "Type" },
        Class =                { link = "Type" },

        Attribute =            { fg = c.slate_cool },
        pythonDecorator =      { fg = c.slate_warm },
        pythonDecoratorName =  { fg = c.slate_warm },
        Punctuation =          { fg = c.slate_cool },
        Special =              { fg = c.slate_cool },
        SpecialChar =          { fg = c.amber_light },
        Tag =                  { fg = c.amber_light },
        Delimiter =            { fg = c.slate_cool },
        Debug =                { fg = c.slate_cool },
        Todo =                 { fg = c.amber_light, bold = true },

        ["@comment"] =                  { link = "Comment" },
        ["@punctuation"] =              { link = "Punctuation" },
        ["@punctuation.bracket"] =      { fg = c.off_gray },
        ["@punctuation.delimiter"] =    { link = "Delimiter" },
        ["@punctuation.separator"] =    { fg = c.off_gray },
        ["@constant"] =                 { link = "Constant" },
        ["@constant.builtin"] =         { link = "Constant" },
        ["@constant.builtin.python"] =  { link = "Boolean" },
        ["@constant.macro"] =           { link = "Define" },
        ["@string"] =                   { link = "String" },
        ["@string.escape"] =            { fg = c.amber_lighter },
        ["@string.special"] =           { fg = c.amber_lighter },
        ["@string.special.url"] =       { fg = c.teal, underline = true },
        ["@character"] =                { link = "Character" },
        ["@number"] =                   { link = "Number" },
        ["@number.float"] =             { link = "Number" },
        ["@boolean"] =                  { link = "Boolean" },
        ["@function"] =                 { link = "Function" },
        ["@function.call"] =            { link = "Function" },
        ["@function.builtin"] =         { link = "Function" },
        ["@function.macro"] =           { link = "Define" },
        ["@function.method"] =          { link = "Function" },
        ["@function.method.call"] =     { link = "Function" },
        ["@variable"] =                 { fg = c.amber_white },
        ["@variable.builtin"] =         { fg = c.amber_white },
        ["@variable.builtin.python"] =  { link = "@variable.parameter" },
        ["@variable.parameter"] =       { link = "Parameter" },
        ["@variable.member"] =          { fg = c.amber_white },
        ["@property"] =                 { fg = c.amber_light },
        ["@constructor"] =              { link = "@type" },
        ["@label"] =                    { link = "Label" },
        ["@operator"] =                 { link = "Operator" },
        ["@keyword"] =                  { link = "Keyword" },
        ["@keyword.function"] =         { link = "Keyword" },
        ["@keyword.coroutine"] =        { link = "Keyword" },
        ["@keyword.conditional"] =      { link = "Conditional" },
        ["@keyword.repeat"] =           { link = "Repeat" },
        ["@keyword.operator"] =         { link = "Operator" },
        ["@keyword.directive"] =        { link = "Statement" },
        ["@keyword.type"] =             { link = "Keyword" },
        ["@keyword.import"] =           { link = "Include" },
        ["@keyword.exception"] =        { link = "Exception" },
        ["@type"] =                     { fg = c.amber_light, italic = true },
        ["@type.builtin"] =             { fg = c.amber, italic = true },
        ["@type.definition"] =          { fg = c.off_white, italic = true },
        ["@type.qualifier"] =           { fg = c.amber_light, italic = true },
        ["@module"] =                   { link = "Type" },
        ["@attribute"] =                { link = "Attribute" },
        ["@attribute.python"] =         { fg = c.off_blue },
        ["@attribute.builtin.python"] = { fg = c.off_blue },
        ["@tag"] =                      { link = "Tag" },
        ["@tag.builtin"] =              { link = "Tag" },
        ["@tag.delimiter"] =            { fg = c.off_gray },
        ["@tag.attribute"] =            { fg = c.off_gray },
        ["@string.special.path"] =      { fg = c.teal, italic = true },
        ["@markup.link.url"] =          { fg = c.teal, underline = true, italic = true },
        ["@markup.raw"] =               { link = "Property" },
        ["@markup.heading"] =           { link = "Keyword" },
        ["@markup.strong"] =            { bold = true },
        ["@markup.italic"] =            { italic = true },
        ["@markup.underline"] =         { underline = true },

        ["@lsp.type.namespace"] =       { link = "@module" },
        ["@lsp.type.type"] =            { link = "@type" },
        ["@lsp.type.class"] =           { link = "@type" },
        ["@lsp.type.enum"] =            { link = "@type" },
        ["@lsp.type.interface"] =       { link = "@type" },
        ["@lsp.type.struct"] =          { link = "@type" },
        ["@lsp.type.typeParameter"] =   { link = "@variable.parameter" },
        ["@lsp.type.parameter"] =       { link = "@variable.parameter" },
        ["@lsp.type.property"] =        { link = "@variable.member" },
        ["@lsp.type.enumMember"] =      { link = "@constant" },
        ["@lsp.type.function"] =        { link = "@function" },
        ["@lsp.type.method"] =          { link = "@function.method" },
        ["@lsp.type.macro"] =           { link = "@function.macro" },
        ["@lsp.type.decorator"] =       { link = "@attribute" },
    }

    for group, highlight in pairs(syntax) do
        vim.api.nvim_set_hl(0, group, highlight)
    end

end

return M
