" Vim color file - mscheme
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

set t_Co=256
let g:colors_name = "mscheme"


let g:fg         = ' guisp = NONE'
let g:fg_none    = ' guifg = NONE      guisp = NONE      ctermfg = NONE'
let g:fg_black   = ' guifg = #000000   guisp = #000000   ctermfg = 0'
let g:fg_black1  = ' guifg = #121212   guisp = #121212   ctermfg = 233'
let g:fg_gray    = ' guifg = #a8a8a8   guisp = #a8a8a8   ctermfg = 248'
let g:fg_gray1   = ' guifg = #6c6c6c   guisp = #6c6c6c   ctermfg = 242'
let g:fg_gray2   = ' guifg = #303030   guisp = #303030   ctermfg = 236'
let g:fg_white   = ' guifg = #ffffff   guisp = #ffffff   ctermfg = 15'
let g:fg_white1  = ' guifg = #dadada   guisp = #dadada   ctermfg = 253'
let g:fg_red     = ' guifg = #ff0000   guisp = #ff0000   ctermfg = 9'
let g:fg_red2    = ' guifg = #ff5f5f   guisp = #ff5f5f   ctermfg = 203'
let g:fg_red3    = ' guifg = #ff8787   guisp = #ff8787   ctermfg = 210'
let g:fg_orange  = ' guifg = #ff8700   guisp = #ff8700   ctermfg = 208'
let g:fg_orange2 = ' guifg = #ffaf5f   guisp = #ffaf5f   ctermfg = 215'
let g:fg_orange3 = ' guifg = #ffd7af   guisp = #ffd7af   ctermfg = 223'
let g:fg_orange4 = ' guifg = #ffd75f   guisp = #ffd75f   ctermfg = 221'
let g:fg_yellow  = ' guifg = #ffff00   guisp = #ffff00   ctermfg = 11'
let g:fg_yellow2 = ' guifg = #ffff87   guisp = #ffff87   ctermfg = 228'
let g:fg_yellow3 = ' guifg = #ffffaf   guisp = #ffffaf   ctermfg = 229'
let g:fg_yellow4 = ' guifg = #ffffd7   guisp = #ffffd7   ctermfg = 230'
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

let g:bg_none    = ' guibg = NONE      ctermbg = NONE'
let g:bg_black   = ' guibg = #000000   ctermbg = 0'
let g:bg_gray3   = ' guibg = #303030   ctermbg = 236'
let g:bg_gray2   = ' guibg = #6c6c6c   ctermbg = 242'
let g:bg_gray1   = ' guibg = #a8a8a8   ctermbg = 248'
let g:bg_pink    = ' guibg = #ffafd7   ctermbg = 218'
let g:bg_yellow  = ' guibg = #ffff87   ctermbg = 228'

let g:t_none     = ' gui = NONE     cterm = NONE'
let g:t_italic   = ' gui = italic   cterm = NONE'
let g:t_bold     = ' gui = bold     cterm = bold'






" BUILDIN GROUPS


exec 'hi ColorColumn '     . g:fg          . g:bg_none    . g:t_none  | " used for the columns set with colorcolumn
exec 'hi Conceal '         . g:fg          . g:bg_none    . g:t_none  | " placeholder characters substituted for concealed
exec 'hi Cursor '          . g:fg_black1   . g:bg_yellow  . g:t_none  | " character under the cursor
exec 'hi lCursor '         . g:fg_black1   . g:bg_yellow  . g:t_none  | " the character under the cursor when language-mappin
exec 'hi CursorIM '        . g:fg_black1   . g:bg_yellow  . g:t_none  | " like Cursor, but used when in IME mode CursorIM
exec 'hi CursorLine '      . g:fg_none     . g:bg_gray3   . g:t_none  | " Screen-column at the cursor, when cursorcolumn is set .
exec 'hi CursorColumn '    . g:fg_none     . g:bg_gray3   . g:t_none  | " Screen-line at the cursor, when cursorline is set.  Low-priority if foreground (ctermfg OR guifg) is not set .
exec 'hi Directory '       . g:fg          . g:bg_none    . g:t_none  | " directory names (and other special names in listings)
exec 'hi DiffAdd '         . g:fg          . g:bg_none    . g:t_none  | " diff mode: Added line diff.txt
exec 'hi DiffChange '      . g:fg          . g:bg_none    . g:t_none  | " diff mode: Changed line diff.txt
exec 'hi DiffDelete '      . g:fg          . g:bg_none    . g:t_none  | " diff mode: Deleted line diff.txt
exec 'hi DiffText '        . g:fg          . g:bg_none    . g:t_none  | " diff mode: Changed text within a changed line diff.txt
exec 'hi EndOfBuffer '     . g:fg          . g:bg_none    . g:t_none  | " filler lines (~) after the end of the buffer.  By default, this is highlighted like hl-NonText.
exec 'hi TermCursor '      . g:fg          . g:bg_none    . g:t_none  | " cursor in a focused terminal
exec 'hi TermCursorNC '    . g:fg          . g:bg_none    . g:t_none  | " cursor in an unfocused terminal
exec 'hi ErrorMsg '        . g:fg          . g:bg_none    . g:t_none  | " error messages on the command line
exec 'hi VertSplit '       . g:fg_black    . g:bg_black   . g:t_none  | " the column separating vertically split windows
exec 'hi Folded '          . g:fg_gray     . g:bg_gray3   . g:t_none  | " line used for closed folds
exec 'hi FoldColumn '      . g:fg_gray     . g:bg_gray3   . g:t_none  | " 'foldcolumn'
exec 'hi SignColumn '      . g:fg_black    . g:bg_black   . g:t_none  | " column where signs are displayed
exec 'hi IncSearch '       . g:fg          . g:bg_black   . g:t_none  | " 'incsearch' highlighting; also used for the text replaced with
exec 'hi Substitute '      . g:fg          . g:bg_black   . g:t_none  | " :substitute replacement text highlighting
exec 'hi LineNr '          . g:fg          . g:bg_black   . g:t_none  | " Line number for  :number and commands, and when 'number'or 'relativenumber' option is set.
exec 'hi CursorLineNr '    . g:fg_gray1    . g:bg_black   . g:t_none  | " Like LineNr when 'cursorline' or 'relativenumber' is set for	the cursor line.
exec 'hi MatchParen '      . g:fg_yellow2  . g:bg_black   . g:t_bold  | " The character under the cursor or just before it, if it		is a paired bracket, and its match. pi_paren.txt

exec 'hi ModeMsg '         . g:fg          . g:bg_black   . g:t_none  | " 'showmode' message (e.g., -- INSERT - )
exec 'hi MsgArea '         . g:fg          . g:bg_black   . g:t_none  | " Area for messages and cmdline
exec 'hi MsgSeparator '    . g:fg          . g:bg_black   . g:t_none  | " Separator for scrolled messages, `msgsep` flag of 'display'
exec 'hi MoreMsg '         . g:fg          . g:bg_black   . g:t_none  | " more-prompt
exec 'hi NonText '         . g:fg_gray1    . g:bg_black   . g:t_none  | " '@' at the end of the window, characters from 'showbreak' 		and other characters that do not really exist in the text
exec 'hi Normal '          . g:fg_white1   . g:bg_black   . g:t_none  | " normal text
exec 'hi NormalFloat '     . g:fg_white1   . g:bg_black   . g:t_none  | " Normal text in floating windows.
exec 'hi NormalNC '        . g:fg_white1   . g:bg_black   . g:t_none  | " normal text in non-current windows
exec 'hi PMenu '           . g:fg_yellow4  . g:bg_none    . g:t_bold  | " Popup menu: normal item.
exec 'hi PMenuSel '        . g:fg_black1   . g:bg_none    . g:t_none  | " Popup menu: selected item.
exec 'hi PMenuSbar '       . g:fg_none     . g:bg_gray2   . g:t_none  | " Popup menu: scrollbar.
exec 'hi PMenuThumb '      . g:fg_none     . g:bg_gray1   . g:t_none  | " Popup menu: Thumb of the scrollbar.
exec 'hi Question '        . g:fg          . g:bg_none    . g:t_none  | " hit-enter prompt and yes/no questions
exec 'hi QuickFixLine '    . g:fg          . g:bg_none    . g:t_none  | " Current quickfix item in the quickfix window. Combined with l-CursorLine when the cursor is there.
exec 'hi Search '          . g:fg_gray2    . g:bg_yellow  . g:t_none  | " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
exec 'hi SpecialKey '      . g:fg_gray1    . g:bg_none    . g:t_none  | " Unprintable characters: text displayed differently from what it really is But not 'listchars' whitespace. hl-Whitespace
exec 'hi SpellBad '        . g:fg          . g:bg_none    . g:t_none  | " Word that is not recognized by the spellchecker. spell Combined with the highlighting used otherwise.
exec 'hi SpellCap '        . g:fg          . g:bg_none    . g:t_none  | " Word that should start with a capital. spell Combined with the highlighting used otherwise.
exec 'hi SpellLocal '      . g:fg          . g:bg_none    . g:t_none  | " Word that is recognized by the spellchecker as one that is used in another region. spell Combined with the highlighting used otherwise.
exec 'hi SpellRare '       . g:fg          . g:bg_none    . g:t_none  | " Word that is recognized by the spellchecker as one that is hardly ever used. spell Combined with the highlighting used otherwise.
exec 'hi StatusLine '      . g:fg_yellow4  . g:bg_none    . g:t_bold  | " status line of current window
exec 'hi StatusLineNC '    . g:fg_gray1    . g:bg_none    . g:t_none  | " status lines of not-current windows Note: if this is equal to StatusLine Vim will use  ^^^ in the status line of the current window.
exec 'hi Title '           . g:fg_yellow4  . g:bg_none    . g:t_bold  | " titles for output from :set all                  ,             :autocmd etc.
exec 'hi TabLine '         . g:fg          . g:bg_none    . g:t_none  | " tab pages line, not active tab page label
exec 'hi TabLineFill '     . g:fg          . g:bg_none    . g:t_none  | " tab pages line, where there are no labels
exec 'hi TabLineSel '      . g:fg          . g:bg_none    . g:t_none  | " tab pages line, active tab page label
exec 'hi Visual '          . g:fg_white    . g:bg_gray2   . g:t_none  | " Visual mode selection
exec 'hi VisualNOS '       . g:fg_white    . g:bg_gray2   . g:t_none  | " Visual mode selection when vim is  Not Owning the Selection .
exec 'hi Whitespace '      . g:fg          . g:bg_none    . g:t_none  | "  nbsp     space     ,   tab  and  trail  in 'listchars'
exec 'hi WarningMsg '      . g:fg_red2     . g:bg_none    . g:t_none  | " warning messages
exec 'hi WildMenu '        . g:fg_white1   . g:bg_black   . g:t_none  | " current match in 'wildmenu' completion



" CODING SYNTAX

exec 'hi Comment '         . g:fg_gray1    . g:bg_none    . g:t_none  | " any comment

exec 'hi Constant '        . g:fg_pink1    . g:bg_none    . g:t_none  | " any constant
exec 'hi String '          . g:fg_pink3    . g:bg_none    . g:t_none  | " a string constant: this is a string
exec 'hi Character '       . g:fg_orange   . g:bg_none    . g:t_none  | " a character constant: 'c', '\n'
exec 'hi Number '          . g:fg_blue2    . g:bg_none    . g:t_none  | " a number constant: 234, 0xff
exec 'hi Boolean '         . g:fg_blue2    . g:bg_none    . g:t_none  | " a boolean constant: TRUE, false
exec 'hi Float '           . g:fg_blue2    . g:bg_none    . g:t_none  | " a floating point constant: 2.3e10

exec 'hi Identifier '      . g:fg_yellow3  . g:bg_none    . g:t_none  | " any variable name
exec 'hi Function '        . g:fg_green    . g:bg_none    . g:t_none  | " function name (also: methods for classes)

exec 'hi Statement '       . g:fg_red      . g:bg_none    . g:t_none  | " any statement
exec 'hi Conditional '     . g:fg_red3     . g:bg_none    . g:t_none  | " if, then, else, endif, switch, etc.
exec 'hi Repeat '          . g:fg_red3     . g:bg_none    . g:t_none  | " for, do, while, etc.
exec 'hi Label '           . g:fg_green1   . g:bg_none    . g:t_none  | " case, default, etc.
exec 'hi Operator '        . g:fg_pink3    . g:bg_none    . g:t_none  | " sizeof, +, * etc.
exec 'hi Keyword '         . g:fg_purple   . g:bg_none    . g:t_none  | " any other keyword
exec 'hi Exception '       . g:fg_green1   . g:bg_none    . g:t_none  | " try, catch, throw

exec 'hi PreProc '         . g:fg_orange4  . g:bg_none    . g:t_none  | " generic Preprocessor
exec 'hi Include '         . g:fg_red2     . g:bg_none    . g:t_none  | " preprocessor #include
exec 'hi Define '          . g:fg_red2     . g:bg_none    . g:t_none  | " preprocessor #define
exec 'hi Macro '           . g:fg_red      . g:bg_none    . g:t_none  | " same as Define
exec 'hi PreCondit '       . g:fg_red      . g:bg_none    . g:t_none  | " preprocessor #if, #else, #endif, etc.

exec 'hi Type '            . g:fg_green1   . g:bg_none    . g:t_none  | " int, long, char, etc.
exec 'hi StorageClass '    . g:fg_green2   . g:bg_none    . g:t_none  | " static, register, volatile, etc.
exec 'hi Structure '       . g:fg_orange2  . g:bg_none    . g:t_none  | " struct, union, enum, etc.
exec 'hi Typedef '         . g:fg_green1   . g:bg_none    . g:t_none  | " A typedef

exec 'hi Special '         . g:fg_purple   . g:bg_none    . g:t_none  | " any special symbol
exec 'hi SpecialChar '     . g:fg_purple   . g:bg_none    . g:t_none  | " special character in a constant
exec 'hi Tag '             . g:fg_orange3  . g:bg_none    . g:t_none  | " you can use CTRL-] on this
exec 'hi Delimiter '       . g:fg_orange3  . g:bg_none    . g:t_none  | " character that needs attention
exec 'hi SpecialComment '  . g:fg_purple   . g:bg_none    . g:t_none  | " special things inside a comment
exec 'hi Debug '           . g:fg_orange3  . g:bg_none    . g:t_none  | " debugging statements

exec 'hi Underlined '      . g:fg_gray1    . g:bg_none    . g:t_none  | " text that stands out, HTML links
exec 'hi Ignore '          . g:fg_gray1    . g:bg_none    . g:t_none  | " left blank, hidden  hl-Ignore
exec 'hi Error '           . g:fg_gray1    . g:bg_none    . g:t_none  | " any erroneous construct
exec 'hi Todo '            . g:fg_gray1    . g:bg_none    . g:t_none  | " anything that needs extra attention; mostly the keywords TODO FIXME and XXX


exec 'hi GitSignsAdd '     . g:fg_green    . g:bg_none
exec 'hi GitSignsChange '  . g:fg_yellow   . g:bg_none
exec 'hi GitSignsDelete '  . g:fg_red      . g:bg_none


" set termguicolors " this variable must be enabled for colors to be applied properly
" a list of groups can be found at `:help nvim_tree_highlight`
exec 'hi NvimTreeFolderIcon '   . g:fg_white . g:bg_black . g:t_none
exec 'hi NvimTreeIndentMarker '  . g:fg_gray1 . g:bg_black . g:t_none

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

" hi Normal
" hi EndOfBuffer
" hi CursorLine
" hi VertSplit
" hi CursorColumn

" hi NvimTreeFileDirty
" hi NvimTreeFileStaged
" hi NvimTreeFileMerge
" hi NvimTreeFileNew
" hi NvimTreeFileRenamed


