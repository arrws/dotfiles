" Vim color file - mscheme
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

set t_Co=256
let g:colors_name = "mscheme"


" let g:fg         = ' guisp = NONE'
let g:fg    = ' guifg = NONE      guisp = NONE      ctermfg = NONE'
let g:fg_none    = ' guifg = NONE      guisp = NONE      ctermfg = NONE'
let g:fg_white   = ' guifg = #ffffff   guisp = #ffffff   ctermfg = 15'
let g:fg_white1  = ' guifg = #dadada   guisp = #dadada   ctermfg = 253'
let g:fg_gray    = ' guifg = #a8a8a8   guisp = #a8a8a8   ctermfg = 248'
let g:fg_gray2   = ' guifg = #6c6c6c   guisp = #6c6c6c   ctermfg = 242'
let g:fg_gray3   = ' guifg = #303030   guisp = #303030   ctermfg = 236'
let g:fg_gray4  = ' guifg = #121212   guisp = #121212   ctermfg = 233'
let g:fg_black   = ' guifg = #000000   guisp = #000000   ctermfg = 0'
let g:fg_red     = ' guifg = #ff0000   guisp = #ff0000   ctermfg = 9'
let g:fg_red1    = ' guifg = #ff5f5f   guisp = #ff5f5f   ctermfg = 203'
let g:fg_red2    = ' guifg = #ff8787   guisp = #ff8787   ctermfg = 210'
let g:fg_orange  = ' guifg = #ff8700   guisp = #ff8700   ctermfg = 208'
let g:fg_orange1 = ' guifg = #ffaf5f   guisp = #ffaf5f   ctermfg = 215'
let g:fg_orange2 = ' guifg = #ffd7af   guisp = #ffd7af   ctermfg = 223'
let g:fg_orange3 = ' guifg = #ffd75f   guisp = #ffd75f   ctermfg = 221'
let g:fg_yellow  = ' guifg = #ffff00   guisp = #ffff00   ctermfg = 11'
let g:fg_yellow1 = ' guifg = #ffff87   guisp = #ffff87   ctermfg = 228'
let g:fg_yellow2 = ' guifg = #ffffaf   guisp = #ffffaf   ctermfg = 229'
let g:fg_yellow3 = ' guifg = #ffffd7   guisp = #ffffd7   ctermfg = 230'
let g:fg_green   = ' guifg = #5fff00   guisp = #5fff00   ctermfg = 82'
let g:fg_green1  = ' guifg = #87ff87   guisp = #87ff87   ctermfg = 120'
let g:fg_green2  = ' guifg = #afffd7   guisp = #afffd7   ctermfg = 158'
let g:fg_blue    = ' guifg = #005fff   guisp = #005fff   ctermfg = 27'
let g:fg_blue1   = ' guifg = #00afff   guisp = #00afff   ctermfg = 39'
let g:fg_blue2   = ' guifg = #5fd7ff   guisp = #5fd7ff   ctermfg = 81'
let g:fg_blue3   = ' guifg = #afd7ff   guisp = #afd7ff   ctermfg = 153'
let g:fg_blue4   = ' guifg = #d7ffff   guisp = #d7ffff   ctermfg = 195'
let g:fg_pink    = ' guifg = #ff00ff   guisp = #ff00ff   ctermfg = 13'
let g:fg_pink1   = ' guifg = #ff87ff   guisp = #ff87ff   ctermfg = 213'
let g:fg_pink2   = ' guifg = #ffb0ff   guisp = #ffb0ff   ctermfg = 219'
let g:fg_pink3   = ' guifg = #ffd7ff   guisp = #ffd7ff   ctermfg = 225'
let g:fg_purple  = ' guifg = #b4adff   guisp = #b4adff   ctermfg = 147'
let g:fg_purple1 = ' guifg = #d7d7ff   guisp = #d7d7ff   ctermfg = 189'

let g:bg         = ' guibg = NONE      ctermbg = NONE'
let g:bg_black   = ' guibg = #000000   ctermbg = 0'
let g:bg_gray4   = ' guibg = #303030   ctermbg = 236'
let g:bg_gray3   = ' guibg = #6c6c6c   ctermbg = 242'
let g:bg_gray2   = ' guibg = #a8a8a8   ctermbg = 248'
let g:bg_pink    = ' guibg = #ffafd7   ctermbg = 218'
let g:bg_yellow  = ' guibg = #ffff87   ctermbg = 228'

let g:t_none     = ' gui = NONE     cterm = NONE'
let g:t_italic   = ' gui = italic   cterm = NONE'
let g:t_bold     = ' gui = bold     cterm = bold'






" BUILDIN GROUPS




exec 'hi Cursor '                . g:fg_gray3   . g:bg_yellow . g:t_none   | " char under the cursor
exec 'hi lCursor '               . g:fg_gray3   . g:bg_yellow . g:t_none   | " the char under the cursor when language-mappin
exec 'hi CursorIM '              . g:fg_gray3   . g:bg_yellow . g:t_none   | " like Cursor, but used when in IME mode CursorIM
exec 'hi CursorColumn '          . g:fg_none    . g:bg_gray4  . g:t_none   | " Screen-line at the cursor, when cursorline is set.  Low-priority if foreground (ctermfg OR guifg) is not set .
exec 'hi TermCursor '            . g:fg_gray3   . g:bg_yellow . g:t_none   | " cursor in a focused terminal
exec 'hi TermCursorNC '          . g:fg_gray3   . g:bg_yellow . g:t_none   | " cursor in an unfocused terminal
exec 'hi Directory '             . g:fg         . g:bg        . g:t_none   | " directory names (and other special names in listings)


" Conditional Line Highlighting
exec 'hi link Conceal NonText'
exec 'hi CursorLine '            . g:fg_none    . g:bg_gray4  . g:t_none   | " Screen-column at the cursor, when cursorcolumn is set .
exec 'hi CursorLineNr '          . g:fg_yellow  . g:bg_black  . g:t_none   | " Like LineNr when 'cursorline' or 'relativenumber' is set for	the cursor line.
exec 'hi LineNr '                . g:fg_gray    . g:bg        . g:t_none   | " Line number for  :number and commands, and when 'number'or 'relativenumber' option is set.
exec 'hi QuickFixLine '          . g:fg         . g:bg_gray2  . g:t_none   | " Current quickfix item in the quickfix window. Combined with l-CursorLine when the cursor is there.
exec 'hi Visual '                . g:fg         . g:bg_gray4  . g:t_none   | " Visual mode selection
exec 'hi VisualNOS '             . g:fg         . g:bg_gray4  . g:t_none   | " Visual mode selection when vim is  Not Owning the Selection .

" Conditional Column Highlighting
exec 'hi ColorColumn '           . g:fg         . g:bg        . g:t_none   | " for the columns
exec 'hi SignColumn '            . g:fg_gray    . g:bg_black  . g:t_none   | " column where signs are displayed



" Popup Menu
exec 'hi PMenu '                 . g:fg_yellow  . g:bg        . g:t_none   | " Popup menu: normal item.
exec 'hi PMenuSel '              . g:fg_green   . g:bg        . g:t_bold   | " Popup menu: selected item.
exec 'hi PMenuSbar '             . g:fg_green   . g:bg_gray3  . g:t_none   | " Popup menu: scrollbar.
exec 'hi PMenuThumb '            . g:fg_none    . g:bg_gray2  . g:t_none   | " Popup menu: Thumb of the scrollbar.
exec 'hi link WildMenu PMenuSel'


exec 'hi Folded '                . g:fg_gray    . g:bg_gray3  . g:t_none   | " line used for closed folds
exec 'hi FoldColumn '            . g:fg_gray    . g:bg_gray3  . g:t_none   | " 'foldcolumn'



" Messages
exec 'hi ErrorMsg '              . g:fg_red     . g:bg_black  . g:t_none   | " error messages on the command line
exec 'hi HintMsg '               . g:fg_red     . g:bg_black  . g:t_none   | " error messages on the command line
exec 'hi InfoMsg '               . g:fg         . g:bg_black  . g:t_none   | " 'showmode' message (e.g., -- INSERT - )
exec 'hi ModeMsg '               . g:fg         . g:bg_black  . g:t_none   | " 'showmode' message (e.g., -- INSERT - )
exec 'hi WarningMsg '            . g:fg_red1    . g:bg        . g:t_none   | " warning messages
exec 'hi Question '              . g:fg         . g:bg        . g:t_none   | " hit-enter prompt and yes/no questions
exec 'hi MsgArea '               . g:fg         . g:bg_black  . g:t_none   | " Area for messages and cmdline
exec 'hi MsgSeparator '          . g:fg         . g:bg_black  . g:t_none   | " Separator for scrolled messages, `msgsep` flag of 'display'



" Searching
exec 'hi IncSearch '             . g:fg_black   . g:bg_pink   . g:t_none   | " 'incsearch' highlighting; also used for the text replaced with
exec 'hi MatchParen '            . g:fg_yellow1 . g:bg_black  . g:t_bold   | " The char under the cursor or just before it, if it		is a paired bracket, and its match. pi_paren.txt
exec 'hi Search '                . g:fg_gray3   . g:bg_pink   . g:t_none   | " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.

exec 'hi Substitute '            . g:fg         . g:bg_black  . g:t_none   | " :substitute replacement text highlighting



exec 'hi SpellBad '              . g:fg         . g:bg        . g:t_none   | " Word that is not recognized by the spellchecker. spell Combined with the highlighting used otherwise.
exec 'hi SpellCap '              . g:fg         . g:bg        . g:t_none   | " Word that should start with a capital. spell Combined with the highlighting used otherwise.
exec 'hi SpellLocal '            . g:fg         . g:bg        . g:t_none   | " Word that is recognized by the spellchecker as one that is used in another region. spell Combined with the highlighting used otherwise.
exec 'hi SpellRare '             . g:fg         . g:bg        . g:t_none   | " Word that is recognized by the spellchecker as one that is hardly ever used. spell Combined with the highlighting used otherwise.



exec 'hi StatusLine '            . g:fg_green1  . g:bg_yellow . g:t_none   | " status line of current window
exec 'hi StatusLineNC '          . g:fg_black   . g:bg_yellow . g:t_bold   | " status lines of not-current windows
exec 'hi link StatusLineTerm StatusLine '
exec 'hi link StatusLineTermNC StatusLineNC '




" Separators
exec 'hi VertSplit '             . g:fg_black   . g:bg_black  . g:t_none   | " the column separating vertically split windows
exec 'hi TabLine '               . g:fg         . g:bg        . g:t_none   | " tab pages line, not active tab page label
exec 'hi TabLineFill '           . g:fg         . g:bg        . g:t_none   | " tab pages line, where there are no labels
exec 'hi TabLineSel '            . g:fg         . g:bg        . g:t_none   | " tab pages line, active tab page label
exec 'hi Title '                 . g:fg_yellow3 . g:bg        . g:t_bold   | " titles for output from :set all   :autocmd etc.


exec 'hi Normal '                . g:fg_white1  . g:bg_black  . g:t_none   | " normal text
exec 'hi NormalFloat '           . g:fg_white1  . g:bg_black  . g:t_none   | " Normal text in floating windows.
exec 'hi NormalNC '              . g:fg_white1  . g:bg_black  . g:t_none   | " normal text in non-current windows




" CODING SYNTAX
" Text
exec 'hi Comment '               . g:fg_gray2   . g:bg        . g:t_italic | " any comment
exec 'hi NonText '               . g:fg_gray3   . g:bg        . g:t_none   | " other chars that do not really exist in the text
exec 'hi link EndOfBuffer NonText'
exec 'hi link Whitespace NonText'

" Literals
exec 'hi Constant '              . g:fg_pink2   . g:bg        . g:t_none   | " any other constant
exec 'hi String '                . g:fg_pink2   . g:bg        . g:t_none   | " a string constant: this is a string
exec 'hi Character '             . g:fg_pink2   . g:bg        . g:t_none   | " a char constant: c, \n
exec 'hi Number '                . g:fg_blue2   . g:bg        . g:t_none   | " a number constant: 234, 0xff
exec 'hi Boolean '               . g:fg_blue1   . g:bg        . g:t_none   | " a boolean constant: TRUE, false
exec 'hi Float '                 . g:fg_blue2   . g:bg        . g:t_none   | " a floating point constant: 2.3e10

" Identifiers
exec 'hi Identifier '            . g:fg_yellow2 . g:bg        . g:t_none   | " any variable name
exec 'hi Function '              . g:fg_green1  . g:bg        . g:t_none   | " function name (also: methods for classes)

" Syntax
exec 'hi Statement '             . g:fg_red1    . g:bg        . g:t_none   | " statements
exec 'hi Conditional '           . g:fg_red2    . g:bg        . g:t_none   | " if, then, else, endif, switch, etc.
exec 'hi Repeat '                . g:fg_red2    . g:bg        . g:t_none   | " for, do, while, etc.
exec 'hi Label '                 . g:fg_purple1 . g:bg        . g:t_none   | " case, default, etc.
exec 'hi Operator '              . g:fg_white   . g:bg        . g:t_none   | " sizeof, +, * etc.
exec 'hi Keyword '               . g:fg_purple  . g:bg        . g:t_none   | " any other keyword
exec 'hi Exception '             . g:fg_green1  . g:bg        . g:t_none   | " try, catch, throw
exec 'hi Noise '                 . g:fg_white   . g:bg        . g:t_none

" Semantics
exec 'hi Type '                  . g:fg_green1  . g:bg        . g:t_none   | " int, long, char, etc.
exec 'hi StorageClass '          . g:fg_purple1 . g:bg        . g:t_none   | " static, register, volatile, etc.
exec 'hi Structure '             . g:fg_orange3 . g:bg        . g:t_none   | " struct, union, enum, etc.
exec 'hi Typedef '               . g:fg_green1  . g:bg        . g:t_none   | " A typedef

" Meta Text
exec 'hi PreProc '               . g:fg_blue2   . g:bg        . g:t_none   | " Preprocessor generic
exec 'hi Include '               . g:fg_blue2   . g:bg        . g:t_none   | " preprocessor #include
exec 'hi Define '                . g:fg_blue2   . g:bg        . g:t_none   | " preprocessor #define
exec 'hi Macro '                 . g:fg_blue2   . g:bg        . g:t_italic | " same as Define
exec 'hi PreCondit '             . g:fg_blue2   . g:bg        . g:t_italic | " preprocessor #if, #else, #endif, etc.

" Edge Cases
exec 'hi Special '               . g:fg_purple  . g:bg        . g:t_none   | " any special symbol
exec 'hi SpecialChar '           . g:fg_purple  . g:bg        . g:t_none   | " special char in a constant
exec 'hi SpecialKey '            . g:fg_purple  . g:bg        . g:t_none   | " special char in a constant
exec 'hi SpecialComment '        . g:fg_gray2   . g:bg        . g:t_bold   | " special things inside a comment
exec 'hi Tag '                   . g:fg_orange2 . g:bg        . g:t_none   | " you can use CTRL-] on this
exec 'hi Delimiter '             . g:fg_white   . g:bg        . g:t_none   | " char that needs attention
exec 'hi Debug '                 . g:fg_orange2 . g:bg        . g:t_none   | " debugging statements

" Help Syntax
exec 'hi Underlined '            . g:fg_gray2   . g:bg        . g:t_none   | " text that stands out, HTML links
exec 'hi Ignore '                . g:fg_gray2   . g:bg        . g:t_none   | " left blank, hidden  hl-Ignore
exec 'hi Error '                 . g:fg_gray2   . g:bg        . g:t_none   | " any erroneous construct
exec 'hi Todo '                  . g:fg_gray2   . g:bg        . g:t_none   | " anything that needs extra attention; mostly the keywords TODO FIXME and XXX
exec 'hi Hint '                  . g:fg_gray2   . g:bg        . g:t_none
exec 'hi Info '                  . g:fg_gray2   . g:bg        . g:t_none
exec 'hi Warning '               . g:fg_gray2   . g:bg        . g:t_none




exec 'hi GitSignsAdd '           . g:fg_green   .           g:bg        .        g:t_none
exec 'hi GitSignsChange '        . g:fg_yellow  .           g:bg        .        g:t_none
exec 'hi GitSignsDelete '        . g:fg_red     .           g:bg        .        g:t_none
exec 'hi DiffAdd '               . g:fg         .           g:bg        .        g:t_none
exec 'hi DiffChange '            . g:fg         .           g:bg        .        g:t_none
exec 'hi DiffDelete '            . g:fg         .           g:bg        .        g:t_none
exec 'hi DiffText '              . g:fg         .           g:bg        .        g:t_none


" set termguicolors " this variable must be enabled for colors to be applied properly
" a list of groups can be found at `:help nvim_tree_highlight`
exec 'hi NvimTreeFolderIcon '    . g:fg_gray2 . g:bg_black . g:t_none
exec 'hi NvimTreeIndentMarker '  . g:fg_gray2 . g:bg_black . g:t_none

" hi NvimTreeSymlink
" hi NvimTreeFolderName
" hi NvimTreeRootFolder
" hi NvimTreeFolderIcon
" hi NvimTreeEmptyFolderName
" hi NvimTreeExecFile
" hi NvimTreeSpecialFile
" hi NvimTreeImageFile
" hi NvimTreeMarkdownFile
" hi NvimTreeIndentMarker

" hi NvimTreeLicenseIcon
" hi NvimTreeYamlIcon
" hi NvimTreeTomlIcon
" hi NvimTreeGitignoreIcon
" hi NvimTreeJsonIcon

" hi NvimTreeLuaIcon
" hi NvimTreePythonIcon
" hi NvimTreeShellIcon
" hi NvimTreeJavascriptIcon
" hi NvimTreeCIcon
" hi NvimTreeReactIcon
" hi NvimTreeHtmlIcon
" hi NvimTreeRustIcon
" hi NvimTreeVimIcon
" hi NvimTreeTypescriptIcon

" hi NvimTreeGitDirty
" hi NvimTreeGitStaged
" hi NvimTreeGitMerge
" hi NvimTreeGitRenamed
" hi NvimTreeGitNew

" hi NvimTreeFileDirty
" hi NvimTreeFileStaged
" hi NvimTreeFileMerge
" hi NvimTreeFileNew
" hi NvimTreeFileRenamed





"  C
exec 'hi link cConstant Constant'
exec 'hi link cCustomClass Type'

"  C++
exec 'hi link cppSTLexception Exception'
exec 'hi link cppSTLnamespace String'

"  Go
exec 'hi link goBlock Delimiter'
exec 'hi link goBoolean Boolean'
exec 'hi link goBuiltins Operator'
exec 'hi link goField Identifier'
exec 'hi link goFloat Float'
exec 'hi link goFormatSpecifier Character'
exec 'hi link goFunction Function'
exec 'hi link goFunctionCall goFunction'
" exec 'hi link goFunctionReturn = NONE
exec 'hi link goMethodCall goFunctionCall'
exec 'hi link goParamType goReceiverType'
exec 'hi link goPointerOperator SpecialChar'
exec 'hi link goPredefinedIdentifiers Constant'
exec 'hi link goReceiver goBlock'
exec 'hi link goReceiverType goTypeName'
exec 'hi link goSimpleParams goBlock'
exec 'hi link goType Type'
exec 'hi link goTypeConstructor goFunction'
exec 'hi link goTypeName Type'
exec 'hi link goVarAssign Identifier'
exec 'hi link goVarDefs goVarAssign'

"  HTML
exec 'hi link htmlArg Label'
" exec 'hi link htmlBold   = {fg=gray_light style bold'},
exec 'hi link htmlTitle htmlBold'
exec 'hi link htmlEndTag htmlTag'
exec 'hi link htmlH1 markdownH1'
exec 'hi link htmlH2 markdownH2'
exec 'hi link htmlH3 markdownH3'
exec 'hi link htmlH4 markdownH4'
exec 'hi link htmlH5 markdownH5'
exec 'hi link htmlH6 markdownH6'
" exec 'hi link htmlItalic  = {style italic'}
exec 'hi link htmlSpecialTagName Keyword'
exec 'hi link htmlTag Special'
exec 'hi link htmlTagN Typedef'
exec 'hi link htmlTagName Type'


"  CSS
exec 'hi link cssAtRule PreCondit'
exec 'hi link cssAttr Keyword'
exec 'hi link cssAttrComma Noise'
exec 'hi link cssAttrRegion Keyword'
exec 'hi link cssBraces Delimiter'
exec 'hi link cssClassName Identifier'
exec 'hi link cssClassNameDot Noise'
exec 'hi link cssFlexibleBoxAttr cssAttr'
exec 'hi link cssFunctionComma Noise'
exec 'hi link cssImportant Exception'
exec 'hi link cssNoise Noise'
exec 'hi link cssProp Label'
exec 'hi link cssPseudoClass Special'
exec 'hi link cssPseudoClassId cssSelectorOp'
exec 'hi link cssSelectorOp Operator'
exec 'hi link cssTagName Structure'
exec 'hi link cssUnitDecorators Type'
exec 'hi link scssAmpersand Special'
exec 'hi link scssAttribute Noise'
exec 'hi link scssBoolean Boolean'
exec 'hi link scssDefault Keyword'
exec 'hi link scssElse scssIf'
" exec 'hi link scssMixinName      = function(self)
" exec 'hi link 	local super = self.cssClassName
" exec 'hi link 	return {bg=super.bg fg=super.fg, style Italic'}
" exec 'hi link end
exec 'hi link scssIf PreCondit'
exec 'hi link scssInclude Include'
exec 'hi link scssSelectorChar Delimiter'
exec 'hi link scssDefinition PreProc'
exec 'hi link scssSelectorName Identifier'
exec 'hi link scssVariable Define'
exec 'hi link scssVariableAssignment Operator'

" . JavaScript
exec 'hi link jsFuncBlock Function'
exec 'hi link jsObjectKey Type'
exec 'hi link jsReturn Keyword'
exec 'hi link jsVariableDef Identifier'

" . Lua
exec 'hi link luaBraces Structure'
exec 'hi link luaBrackets Delimiter'
exec 'hi link luaBuiltin Keyword'
exec 'hi link luaComma Delimiter'
exec 'hi link luaFuncArgName Identifier'
exec 'hi link luaFuncCall Function'
exec 'hi link luaFuncId luaNoise'
exec 'hi link luaFuncKeyword Type'
exec 'hi link luaFuncName Function'
exec 'hi link luaFuncParens Delimiter'
exec 'hi link luaFuncTable Structure'
exec 'hi link luaIn luaRepeat'
exec 'hi link luaLocal Type'
exec 'hi link luaNoise Delimiter'
exec 'hi link luaParens Delimiter'
exec 'hi link luaSpecialTable StorageClass'
exec 'hi link luaSpecialValue Function'

" . Markdown
" exec 'hi link markdownH1 = {fg=red style bold'},
" exec 'hi link markdownH2 = {fg=orange style bold'},
" exec 'hi link markdownH3 = {fg=yellow style bold'},
" exec 'hi link markdownH4 = {fg=green_dark style bold'},
" exec 'hi link markdownH5 = {fg=cyan style bold'},
" exec 'hi link markdownH6 = {fg=purple_light style bold'},
exec 'hi link mkdBold Ignore'
exec 'hi link mkdCode Keyword'
exec 'hi link mkdCodeDelimiter mkdBold'
exec 'hi link mkdCodeStart mkdCodeDelimiter'
exec 'hi link mkdCodeEnd mkdCodeStart'
exec 'hi link mkdHeading Delimiter'
exec 'hi link mkdItalic mkdBold'
exec 'hi link mkdLineBreak NonText'
exec 'hi link mkdListItem Special'
" exec 'hi link mkdRule = function(self) return {fg=self.Ignore.fg style={'underline', color=self.Delimiter.fg}} end,



" . Python
exec 'hi link pythonBrackets Delimiter'
exec 'hi link pythonBuiltinFunc Operator'
exec 'hi link pythonBuiltinObj Type'
exec 'hi link pythonBuiltinType Type'
exec 'hi link pythonClass Structure'
exec 'hi link pythonClassParameters pythonParameters'
exec 'hi link pythonDecorator PreProc'
exec 'hi link pythonDottedName Identifier'
exec 'hi link pythonError Error'
exec 'hi link pythonException Exception'
exec 'hi link pythonInclude Include'
exec 'hi link pythonIndentError pythonError'
exec 'hi link pythonLambdaExpr pythonOperator'
exec 'hi link pythonOperator Operator'
exec 'hi link pythonParam Identifier'
exec 'hi link pythonParameters Delimiter'
exec 'hi link pythonSelf Statement'
exec 'hi link pythonSpaceError pythonError'
exec 'hi link pythonStatement Statement'

" . SQL
exec 'hi link sqlKeyword Keyword'
exec 'hi link sqlParen Delimiter'
exec 'hi link sqlSpecial Constant'
exec 'hi link sqlStatement Statement'
exec 'hi link sqlParenFunc Function'


"  nvim-treesitter
exec 'hi link TSConstBuiltin Constant'
exec 'hi link TSConstructor Typedef'
exec 'hi link TSFuncBuiltin Function'
exec 'hi link TSStringEscape Character'
exec 'hi link TSStringRegex SpecialChar'
exec 'hi link TSURI Tag'
exec 'hi link TSVariableBuiltin Identifier'


"  vim-jumpmotion / vim-easymotion
exec 'hi link EasyMotion IncSearch'
exec 'hi link JumpMotion EasyMotion'


"  Help
exec 'hi link helpHeader Label'
exec 'hi link helpOption Keyword'
exec 'hi link helpHeadline Title'
exec 'hi link helpSectionDelim Delimiter'
exec 'hi link helpHyperTextJump Underlined'





