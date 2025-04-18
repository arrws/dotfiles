local c = require "xtheme.colors"

local M = {}

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

function M.load()
    -- Reset existing highlights
    vim.cmd "hi clear"
    if vim.fn.exists "syntax_on" then
        vim.cmd "syntax reset"
    end

    vim.o.background = "dark"
    vim.g.colors_name = "xtheme"

    ------ BUILDIN

    hl("Normal",                { fg = c.whiteish, bg = c.black }) -- normal text
    hl("NormalNC",              { fg = c.whiteish, bg = c.black }) -- normal text in non-current windows

    hl("WinSeparator",          { fg = c.black }) -- vertical bar splitting windows

    hl("IndentBlanklineChar",   { fg = c.blackish, bg = c.black })
    hl("IndentBlanklineSpaceChar", { link = "IndentBlanklineChar" })
    hl("IndentBlanklineContextChar", { link = "IndentBlanklineChar" })

    -- Floating Windows
    hl("NormalFloat",           { fg = c.whiteish, bg = c.black }) -- normal text in floating windows
    hl("FloatBorder",           { fg = c.blackish }) -- floating window border

    -- Telescope
    hl("TelescopeBorder",       { link = "FloatBorder" })
    hl("TelescopeNormal",       { link = "Normal" })
    hl("TelescopeMatching",     { fg = c.term_cyan, bg = c.blue_dark })
    hl("TelescopeSelection",    { link = "WildMenu" })

    -- Statusbar Popup Menu
    hl("WildMenu",              { fg = c.green, bg = c.green_darkest }) -- active
    hl("StatusLine",            { fg = c.grey_72, bg = c.black }) -- inactive
    hl("StatusLineNC",          { fg = c.black }) -- not-current windows
    hl("StatusLineTerm",        { link = "StatusLine" })
    hl("StatusLineTermNC",      { link = "StatusLineNC" })

    -- Tabs Selection Menu
    hl("TabLine",               { link = "StatusLine" }) -- inactive tab text
    hl("TabLineSel",            { link = "WildMenu" }) -- active tab text

    -- Autocomplete Popup Menu
    hl("PMenuSel",              { link = "WildMenu" }) -- selected item.
    hl("PMenu",                 { link = "StatusLine" }) -- normal item.
    hl("PMenuSbar",             { link = "StatusLine" }) -- scrollbar.
    hl("PMenuThumb",            { link = "StatusLine" }) -- Thumb of the scrollbar.

    -- Searching
    hl("IncSearch",             { fg = c.term_cyan, bg = c.blue_dark, bold = true }) -- /smth 'incsearch' highlighting
    hl("Search",                { link = "TelescopeMatching" }) -- /smth all other, last search pattern highlighting
    hl("CurSearch",             { fg = c.term_cyan, bg = c.blue_dark, bold = true }) -- /smth all other, last search pattern highlighting
    hl("Substitute",            { link = "TelescopeMatching" }) -- /smth all other, last search pattern highlighting

    hl("MiniJump2dSpot",        { link = "TelescopeMatching" }) -- easymotion
    hl("MiniJump",              { link = "TelescopeMatching" }) -- f replacement

    -- Cursor highlighting
    hl("Cursor",                { fg = c.white }) -- char under the cursor
    hl("lCursor",               { link = "Cursor" }) -- the char under the cursor when language-mappin
    hl("CursorIM",              { link = "Cursor" }) -- like Cursor, but used when in IME mode CursorIM
    -- hl("CursorLine",            { bg = c.blackish }) -- Screen-column at the cursor, when cursorcolumn is set .
    -- hl("CursorColumn",          { link = "CursorLine" }) -- Screen-line at the cursor  , when cursorline is set.  Low-priority if foreground (ctermfg OR guifg) is not set .

    -- Tree
	hl("NvimTreeNormal",        { fg = c.whiteish }) -- file names
    hl("Directory",             { fg = c.grey_2, bold=true}) -- directory names
	hl("NvimTreeRootFolder",    { fg = c.grey_3 })
	hl("NvimTreeSpecialFile",   { fg = c.grey_2, italic=true  })
	hl("NvimTreeExecFile",      { link="NvimTreeSpecialFile" })
	hl("NvimTreeImageFile",     { link="NvimTreeSpecialFile" })
	hl("NvimTreeSymlink",       { link="NvimTreeSpecialFile" })
	hl("NvimTreeFolderIcon",    { fg = c.grey_0 })
	hl("NvimTreeFileIcon",      { link="NvimTreeFolderIcon" })
    hl("NvimTreeWindowPicker",  { fg = c.green, bold=true})

    -- -- Conditional Line/Column highlighting
    hl("VertSplit",             { fg = c.black }) -- column separating vertically split windows
    hl("Title",                 { fg = c.white }) -- titles for output from :set all   :autocmd etc.
    -- hl("Visual",                { bg = c.editor_bg }) -- Visual mode selection
    -- hl("VisualNOS",             { link = "Visual" }) -- Visual mode selection when vim is  Not Owning the Selection .
    -- hl("Conceal",               {}) -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- hl("CursorLineNr",          { fg = c.yellow }) -- Like LineNr when 'cursorline' or 'relativenumber' is set for  the cursor line.
    -- hl("LineNr",                { fg = c.white }) -- Line number for  :number and commands, and when 'number'or 'relativenumber' option is set.
    -- hl("QuickFixLine",          { bg = c.white }) -- Current quickfix item in the quickfix window. Combined with l-CursorLine when the cursor is there.
    -- hl("ColorColumn",           {}) -- columns color
    -- hl("SignColumn",            { fg = c.white }) -- column where signs are displayed
    -- hl("Folded",                {}) -- line used for closed folds
    -- hl("FoldColumn",            {}) -- foldcolumn

    -- Diff
    hl("DiffAdd",               { fg = c.green })
    hl("DiffChange",            { bg = c.yellow })
    hl("DiffDelete",            { fg = c.red })
    hl("DiffText",              { fg = c.blue })

    hl("MiniDiffOverAdd",       { link = "DiffAdd" })
    hl("MiniDiffOverDelete",    { link = "DiffDelete" })
    hl("MiniDiffOverChange",    { link = "DiffChange" })

    -- Messages
    hl("ErrorMsg",              { fg = c.red }) -- error messages on the command line
    hl("WarningMsg",            { fg = c.yellow }) -- warning messages
    hl("InfoMsg",               { fg = c.blue }) -- 'showmode' message (e.g., INSERT)
    hl("HintMsg",               { fg = c.green }) -- error messages on the command line

    -- base hl group. Other Diagnostic highlights link to this by default. See :h diagnostic-highlights
    hl("DiagnosticError",       { link = "ErrorMsg" })
    hl("DiagnosticWarn",        { link = "WarningMsg" })
    hl("DiagnosticInfo",        { link = "InfoMsg" })
    hl("DiagnosticHint",        { link = "HintMsg" })

    hl("NvimTreeLspDiagnosticsError",       { link = "DiagnosticError" })
    hl("NvimTreeLspDiagnosticsHint",        { link = "DiagnosticHint" })
    hl("NvimTreeLspDiagnosticsInformation", { link = "DiagnosticInfo" })
    hl("NvimTreeLspDiagnosticsWarning",     { link = "DiagnosticWarn" })

    ------ CODING

    -- Text
    hl("Comment",               { fg = c.grey_1, italic = true }) -- any comment
    hl("SpecialComment",        { fg = c.grey_1, italic = true }) -- special things inside a comment
    hl("NonText",               { fg = c.grey_3 }) -- other chars that do not really exist in the text
    hl("EndOfBuffer",           { fg = c.grey_3 })
    hl("Whitespace",            { fg = c.grey_0 })

    hl("InlayHints",            { fg = c.green_dark })
    hl("LspInlayHint",          { link = "InlayHints" })

    -- Literals
    hl("Boolean",               { fg = c.purple_1, bold = true }) -- boolean constant: TRUE, false
    hl("Number",                { fg = c.purple_2 }) -- number constant: 234, 0xff
    hl("Float",                 { fg = c.purple_3 }) -- floating point constant: 2.3e10
    hl("Character",             { fg = c.pink_1 }) -- char constant: c, \n
    hl("String",                { fg = c.pink }) -- string constant: this is a string
    hl("Special",               { fg = c.pink_2, bold = true }) -- any special symbol
    hl("SpecialChar",           { fg = c.pink_3, bold = true }) -- special char in a constant
    hl("SpecialKey",            { fg = c.whiteish, bold = true }) -- special char in a constant
    hl("Delimiter",             { fg = c.whiteish }) -- char that needs attention

    -- Identifiers
    hl("Constant",              { fg = c.grey_3 }) -- any other constant
    hl("Identifier",            { fg = c.white }) -- any variable name
    hl("Function",              { fg = c.yellow_3 }) -- function name (also: methods for classes)

    -- Syntax
    hl("Statement",             { fg = c.green }) -- statements
    hl("Conditional",           { fg = c.yellow_4 }) -- if, then, else, endif, switch, etc.
    hl("Repeat",                { fg = c.yellow_4 }) -- for, do, while, etc.
    hl("Label",                 { fg = c.yellow_5 }) -- case, default, etc.
    hl("Exception",             { fg = c.yellow_5 }) -- try, catch, throw
    hl("Operator",              { fg = c.white, bold = true }) -- sizeof, +, * etc.
    hl("Keyword",               { fg = c.yellow_5 }) -- any other keyword

    -- Semantics
    hl("StorageClass",          { fg = c.yellow_2 }) -- static, register, volatile, etc.
    hl("Structure",             { fg = c.yellow_1 }) -- struct, union, enum, etc.
    hl("Type",                  { fg = c.yellow_4 }) -- int, long, char, etc.
    hl("Typedef",               { fg = c.yellow_4 }) -- A typedef

    -- Meta Text
    hl("Include",               { fg = c.red_1, italic = true }) -- preprocessor #include
    hl("PreCondit",             { fg = c.red_1, italic = true }) -- preprocessor #if, #else, #endif, etc.
    hl("PreProc",               { fg = c.red_1, italic = true }) -- Preprocessor generic ??? functoin params in typescript
    hl("Define",                { fg = c.red_1, italic = true }) -- preprocessor #define
    hl("Macro",                 { fg = c.red_1, italic = true }) -- same as Define

    -- Edge Cases
    hl("Tag",                   { fg = c.white, bold = true }) -- paranthesis you can use CTRL-] on this
    hl("Debug",                 { fg = c.white, bold = true }) -- debugging statements
    hl("SpellCap",              { fg = c.white }) -- Nvim Tree files text
end

return M
