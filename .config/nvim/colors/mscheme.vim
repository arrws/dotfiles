" Vim color file - mscheme
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

set t_Co=256
let g:colors_name = "mscheme"



let g:c_cursor   = 'guifg = NONE      guibg = #303030   guisp = NONE       gui = NONE     ctermfg = NONE   ctermbg = 236    cterm = NONE'
let g:c_bg       = 'guifg = #000000   guibg = #000000   guisp = #000000    gui = NONE     ctermfg = 0      ctermbg = 0      cterm = NONE'
let g:c_bg1      = 'guifg = NONE      guibg = #626262   guisp = NONE       gui = NONE     ctermfg = NONE   ctermbg = 241    cterm = NONE'
let g:c_bg2      = 'guifg = NONE      guibg = #a8a8a8   guisp = NONE       gui = NONE     ctermfg = NONE   ctermbg = 248    cterm = NONE'
let g:c_normal   = 'guifg = #dadada   guibg = #000000   guisp = #dadada    gui = NONE     ctermfg = 253    ctermbg = NONE   cterm = NONE'
let g:c_visual   = 'guifg = #ffffff   guibg = #3a3a3a   guisp = #ffffff    gui = NONE     ctermfg = 15     ctermbg = 237    cterm = NONE'
let g:c_fold     = 'guifg = #a8a8a8   guibg = #303030   guisp = #a8a8a8    gui = NONE     ctermfg = 248    ctermbg = 237    cterm = NONE'
let g:c_search   = 'guifg = #303030   guibg = #ffafd7   guisp = #303030    gui = NONE     ctermfg = 236    ctermbg = 218    cterm = NONE'
let g:c_selected = 'guifg = #121212   guibg = #ffff87   guisp = #121212    gui = NONE     ctermfg = 233    ctermbg = 228    cterm = NONE'
let g:c_gray     = 'guifg = #6c6c6c   guibg = NONE      guisp = #6c6c6c    gui = italic   ctermfg = 242    ctermbg = NONE   cterm = NONE'
let g:c_red      = 'guifg = #ff0000   guibg = NONE      guisp = #ff0000    gui = NONE     ctermfg = 9      ctermbg = NONE   cterm = NONE'
let g:c_red2     = 'guifg = #ff5f5f   guibg = NONE      guisp = #ff5f5f    gui = NONE     ctermfg = 203    ctermbg = NONE   cterm = NONE'
let g:c_red3     = 'guifg = #ff8787   guibg = NONE      guisp = #ff8787    gui = NONE     ctermfg = 210    ctermbg = NONE   cterm = NONE'
let g:c_orange   = 'guifg = #ff8700   guibg = NONE      guisp = #ff8700    gui = NONE     ctermfg = 208    ctermbg = NONE   cterm = NONE'
let g:c_orange2  = 'guifg = #ffaf5f   guibg = NONE      guisp = #ffaf5f    gui = NONE     ctermfg = 215    ctermbg = NONE   cterm = NONE'
let g:c_orange3  = 'guifg = #ffd7af   guibg = NONE      guisp = #ffd7af    gui = NONE     ctermfg = 223    ctermbg = NONE   cterm = NONE'
let g:c_orange4  = 'guifg = #ffd75f   guibg = NONE      guisp = #ffd75f    gui = NONE     ctermfg = 221    ctermbg = NONE   cterm = NONE'
let g:c_yellow   = 'guifg = #ffff00   guibg = NONE      guisp = #ffff00    gui = NONE     ctermfg = 11     ctermbg = NONE   cterm = NONE'
let g:c_yellow2  = 'guifg = #ffff87   guibg = NONE      guisp = #ffff87    gui = bold     ctermfg = 228    ctermbg = NONE   cterm = bold'
let g:c_yellow3  = 'guifg = #ffffaf   guibg = NONE      guisp = #ffffaf    gui = NONE     ctermfg = 229    ctermbg = NONE   cterm = NONE'
let g:c_yellow4  = 'guifg = #ffffd7   guibg = NONE      guisp = #ffffd7    gui = bold     ctermfg = 230    ctermbg = NONE   cterm = bold'
let g:c_green    = 'guifg = #5fff00   guibg = NONE      guisp = #5fff00    gui = NONE     ctermfg = 82     ctermbg = NONE   cterm = NONE'
let g:c_green1   = 'guifg = #87ff87   guibg = NONE      guisp = #87ff87    gui = NONE     ctermfg = 120    ctermbg = NONE   cterm = NONE'
let g:c_green2   = 'guifg = #afffd7   guibg = NONE      guisp = #afffd7    gui = NONE     ctermfg = 158    ctermbg = NONE   cterm = NONE'
let g:c_blue     = 'guifg = #005fff   guibg = NONE      guisp = #005fff    gui = NONE     ctermfg = 27     ctermbg = NONE   cterm = NONE'
let g:c_blue1    = 'guifg = #00afff   guibg = NONE      guisp = #00afff    gui = NONE     ctermfg = 39     ctermbg = NONE   cterm = NONE'
let g:c_blue2    = 'guifg = #5fd7ff   guibg = NONE      guisp = #5fd7ff    gui = NONE     ctermfg = 81     ctermbg = NONE   cterm = NONE'
let g:c_blue3    = 'guifg = #afd7ff   guibg = NONE      guisp = #afd7ff    gui = NONE     ctermfg = 153    ctermbg = NONE   cterm = NONE'
let g:c_blue4    = 'guifg = #d7ffff   guibg = NONE      guisp = #d7ffff    gui = NONE     ctermfg = 195    ctermbg = NONE   cterm = NONE'
let g:c_pink     = 'guifg = #ff00ff   guibg = NONE      guisp = #ff00ff    gui = NONE     ctermfg = 13     ctermbg = NONE   cterm = NONE'
let g:c_pink1    = 'guifg = #ff87ff   guibg = NONE      guisp = #ff87ff    gui = NONE     ctermfg = 213    ctermbg = NONE   cterm = NONE'
let g:c_pink2    = 'guifg = #ffb0ff   guibg = NONE      guisp = #ffb0ff    gui = None     ctermfg = 219    ctermbg = NONE   cterm = NONE'
let g:c_pink3    = 'guifg = #ffd7ff   guibg = NONE      guisp = #ffd7ff    gui = None     ctermfg = 225    ctermbg = NONE   cterm = NONE'
let g:c_purple   = 'guifg = #b4adff   guibg = NONE      guisp = #b4adff    gui = italic   ctermfg = 147    ctermbg = NONE   cterm = NONE'
let g:c_purple1  = 'guifg = #d7d7ff   guibg = NONE      guisp = #d7d7ff    gui = NONE     ctermfg = 189    ctermbg = NONE   cterm = NONE'

let g:c          = 'guisp = #NONE'



" BUILDIN GROUPS


exec 'hi ColorColumn '          .  g:c          | " used for the columns set with colorcolumn
exec 'hi Conceal '              .  g:c          | " placeholder characters substituted for concealed
exec 'hi Cursor '               .  g:c_selected | " character under the cursor
exec 'hi lCursor '              .  g:c_selected | " the character under the cursor when language-mappin
exec 'hi CursorIM '             .  g:c_selected | " like Cursor, but used when in IME mode CursorIM
exec 'hi CursorLine '           .  g:c_cursor   | " Screen-column at the cursor, when cursorcolumn is set .
exec 'hi CursorColumn '         .  g:c_cursor   | " Screen-line at the cursor, when cursorline is set.  Low-priority if foreground (ctermfg OR guifg) is not set .
exec 'hi Directory '            .  g:c          | " directory names (and other special names in listings)
exec 'hi DiffAdd '              .  g:c          | " diff mode: Added line diff.txt
exec 'hi DiffChange '           .  g:c          | " diff mode: Changed line diff.txt
exec 'hi DiffDelete '           .  g:c          | " diff mode: Deleted line diff.txt
exec 'hi DiffText '             .  g:c          | " diff mode: Changed text within a changed line diff.txt
exec 'hi EndOfBuffer '          .  g:c          | " filler lines (~) after the end of the buffer.  By default, this is highlighted like hl-NonText.
exec 'hi TermCursor '           .  g:c          | " cursor in a focused terminal
exec 'hi TermCursorNC '         .  g:c          | " cursor in an unfocused terminal
exec 'hi ErrorMsg '             .  g:c          | " error messages on the command line
exec 'hi VertSplit '            .  g:c_bg       | " the column separating vertically split windows
exec 'hi Folded '               .  g:c_fold     | " line used for closed folds
exec 'hi FoldColumn '           .  g:c_fold     | " 'foldcolumn'
exec 'hi SignColumn '           .  g:c_bg       | " column where signs are displayed
exec 'hi IncSearch '            .  g:c          | " 'incsearch' highlighting; also used for the text replaced with
exec 'hi Substitute '           .  g:c          | " :substitute replacement text highlighting
exec 'hi LineNr '               .  g:c          | " Line number for  :number and commands, and when 'number'or 'relativenumber' option is set.
exec 'hi CursorLineNr '         .  g:c_gray     | " Like LineNr when 'cursorline' or 'relativenumber' is set for	the cursor line.
exec 'hi MatchParen '           .  g:c_yellow2  | " The character under the cursor or just before it, if it		is a paired bracket, and its match. pi_paren.txt
exec 'hi ModeMsg '              .  g:c          | " 'showmode' message (e.g., -- INSERT - )
exec 'hi MsgArea '              .  g:c          | " Area for messages and cmdline
exec 'hi MsgSeparator '         .  g:c          | " Separator for scrolled messages, `msgsep` flag of 'display'
exec 'hi MoreMsg '              .  g:c          | " more-prompt
exec 'hi NonText '              .  g:c_gray     | " '@' at the end of the window, characters from 'showbreak' 		and other characters that do not really exist in the text
exec 'hi Normal '               .  g:c_normal   | " normal text
exec 'hi NormalFloat '          .  g:c_normal   | " Normal text in floating windows.
exec 'hi NormalNC '             .  g:c_normal   | " normal text in non-current windows
exec 'hi PMenu '                .  g:c_yellow4  | " Popup menu: normal item.
exec 'hi PMenuSel '             .  g:c_selected | " Popup menu: selected item.
exec 'hi PMenuSbar '            .  g:c_bg1      | " Popup menu: scrollbar.
exec 'hi PMenuThumb '           .  g:c_bg2      | " Popup menu: Thumb of the scrollbar.
exec 'hi Question '             .  g:c          | " hit-enter prompt and yes/no questions
exec 'hi QuickFixLine '         .  g:c          | " Current quickfix item in the quickfix window. Combined with l-CursorLine when the cursor is there.
exec 'hi Search '               .  g:c_search   | " Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
exec 'hi SpecialKey '           .  g:c_gray     | " Unprintable characters: text displayed differently from what it really is But not 'listchars' whitespace. hl-Whitespace
exec 'hi SpellBad '             .  g:c          | " Word that is not recognized by the spellchecker. spell Combined with the highlighting used otherwise.
exec 'hi SpellCap '             .  g:c          | " Word that should start with a capital. spell Combined with the highlighting used otherwise.
exec 'hi SpellLocal '           .  g:c          | " Word that is recognized by the spellchecker as one that is used in another region. spell Combined with the highlighting used otherwise.
exec 'hi SpellRare '            .  g:c          | " Word that is recognized by the spellchecker as one that is hardly ever used. spell Combined with the highlighting used otherwise.
exec 'hi StatusLine '           .  g:c_yellow4  | " status line of current window
exec 'hi StatusLineNC '         .  g:c_gray     | " status lines of not-current windows Note: if this is equal to StatusLine Vim will use " ^^^" in the status line of the current window.
exec 'hi Title '                .  g:c_yellow4  | " titles for output from :set all                  ,             :autocmd etc.
exec 'hi TabLine '              .  g:c          | " tab pages line, not active tab page label
exec 'hi TabLineFill '          .  g:c          | " tab pages line, where there are no labels
exec 'hi TabLineSel '           .  g:c          | " tab pages line, active tab page label
exec 'hi Visual '               .  g:c_visual   | " Visual mode selection
exec 'hi VisualNOS '            .  g:c_visual   | " Visual mode selection when vim is " Not Owning the Selection " .
exec 'hi Whitespace '           .  g:c          | "  nbsp    " space    " ,  " tab " and " trail " in 'listchars'
exec 'hi WarningMsg '           .  g:c_red2     | " warning messages
exec 'hi WildMenu '             .  g:c_normal   | " current match in 'wildmenu' completion





" CODING SYNTAX

exec 'hi Comment '              . g:c_gray     | " any comment

exec 'hi Constant '             . g:c_pink1    | " any constant
exec 'hi String '               . g:c_pink3    | " a string constant: "this is a string"
exec 'hi Character '            . g:c_orange   | " a character constant: 'c', '\n'
exec 'hi Number '               . g:c_blue2    | " a number constant: 234, 0xff
exec 'hi Boolean '              . g:c_blue2    | " a boolean constant: TRUE, false
exec 'hi Float '                . g:c_blue2    | " a floating point constant: 2.3e10

exec 'hi Identifier '           . g:c_yellow3  | " any variable name
exec 'hi Function '             . g:c_green    | " function name (also: methods for classes)

exec 'hi Statement '            . g:c_red      | " any statement
exec 'hi Conditional '          . g:c_red3     | " if, then, else, endif, switch, etc.
exec 'hi Repeat '               . g:c_red3     | " for, do, while, etc.
exec 'hi Label '                . g:c_green1   | " case, default, etc.
exec 'hi Operator '             . g:c_pink3    | " "sizeof", "+", "*", etc.
exec 'hi Keyword '              . g:c_purple   | " any other keyword
exec 'hi Exception '            . g:c_green1   | " try, catch, throw

exec 'hi PreProc '              . g:c_orange4  | " generic Preprocessor
exec 'hi Include '              . g:c_red2     | " preprocessor #include
exec 'hi Define '               . g:c_red2     | " preprocessor #define
exec 'hi Macro '                . g:c_red      | " same as Define
exec 'hi PreCondit '            . g:c_red      | " preprocessor #if, #else, #endif, etc.

exec 'hi Type '                 . g:c_green1   | " int, long, char, etc.
exec 'hi StorageClass '         . g:c_green2   | " static, register, volatile, etc.
exec 'hi Structure '            . g:c_orange2  | " struct, union, enum, etc.
exec 'hi Typedef '              . g:c_green1   | " A typedef

exec 'hi Special '              . g:c_purple   | " any special symbol
exec 'hi SpecialChar '          . g:c_purple   | " special character in a constant
exec 'hi Tag '                  . g:c_orange3  | " you can use CTRL-] on this
exec 'hi Delimiter '            . g:c_orange3  | " character that needs attention
exec 'hi SpecialComment '       . g:c_purple   | " special things inside a comment
exec 'hi Debug '                . g:c_orange3  | " debugging statements

exec 'hi Underlined '           . g:c_gray     | " text that stands out, HTML links
exec 'hi Ignore '               . g:c_gray     | " left blank, hidden  hl-Ignore
exec 'hi Error '                . g:c_gray     | " any erroneous construct
exec 'hi Todo '                 . g:c_gray     | " anything that needs extra attention; mostly the keywords TODO FIXME and XXX


exec 'hi GitSignsAdd '           .  g:c_green
exec 'hi GitSignsChange '        .  g:c_yellow
exec 'hi GitSignsDelete '        .  g:c_red


" set termguicolors " this variable must be enabled for colors to be applied properly
" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=black guifg=gray ctermfg=1 ctermbg=0
hi NvimTreeIndentMarker guifg=gray ctermfg=1

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


