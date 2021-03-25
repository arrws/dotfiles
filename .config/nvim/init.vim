" set shell=/bin/bash

" to install vim-plug:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

call plug#begin('~/.config/nvim/bundle')

Plug 'junegunn/goyo.vim'                                    " distraction free writting
Plug 'moll/vim-bbye'                                        " close buffers without closing windows with :Bdelete

Plug 'hoob3rt/lualine.nvim'                                 " lua statusline
Plug 'kyazdani42/nvim-tree.lua'                             " file explorer

Plug 'neovim/nvim-lspconfig'                                " for LSP help
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " LSP based syntax highlighting
Plug 'nvim-lua/completion-nvim'                             " LSP autocomplete
Plug 'ojroques/nvim-lspfuzzy'                               " use FZF for displaying LSP searches
Plug 'aca/completion-tabnine', {'do': './install.sh'}       " ML autocomplete

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         " fuzzy searcher
Plug 'junegunn/fzf.vim'                                     " fuzzy searcher helpers
Plug 'phaazon/hop.nvim'                                     " better easy-motion

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'                                   " git commands

Plug 'junegunn/vim-easy-align'                              " alligning text
Plug 'tpope/vim-surround'                                   " smart bindings to change surrounding elements
Plug 'tpope/vim-repeat'                                     " enable . repeat for plugins
Plug 'tpope/vim-commentary'                                 " bindings to comment stuff out
Plug 'jiangmiao/auto-pairs'                                 " auto-complete parenthesis and other brackets
Plug 'AndrewRadev/linediff.vim'                             " :Linediff diff two blocks of text selected in visual mode
Plug 'AndrewRadev/splitjoin.vim'                            " reformat between single-line statement and a multi-line one
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }  " display thin vertical lines at each indentation level
Plug 'ntpeters/vim-better-whitespace'                       " for trailling whitespace

Plug 'ap/vim-css-color'
call plug#end()

set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

set mouse=a             " enable mouse mode

set hidden              " do not save when swithing buffers -> work with multiple files easier
set nobackup
set noswapfile
set history=1000        " status line commands history
set showcmd             " show in status line the command you're typing
set laststatus=2        " status line
set cmdheight=1         " height status line
set wildmenu            " status line menu
set wildmode=full
set wildoptions=tagfile

set number              " or relativenumber
set numberwidth=1       " number column width
set ruler               " show current column in status bar right corner
set signcolumn=yes:1
" set signcolumn=number	" merge sign and numbers gutter golumns

set cursorline          " highlight current line
set foldcolumn=1        " number of folds / nesting level (?) the width of the grey column on the left side
set showmatch           " show matching braces

set undofile            " save undo history



colorscheme mscheme
let g:lualine = {
    \'options' : {
    \  'theme' : 'mtheme',
    \  'section_separators' : ['', ''],
    \  'component_separators' : ['|', '|'],
    \  'icons_enabled' : v:false,
    \},
    \'sections' : {
    \  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
    \  'lualine_b' : [ ['branch', {'icon': 'b',}, ], ],
    \  'lualine_c' : [ ['filename', {'file_status': v:true,},], ],
    \  'lualine_x' : [ 'encoding', 'fileformat', 'filetype', 'progress' ],
    \  'lualine_y' : [ 'location'  ],
    \  'lualine_z' : [  ],
    \},
    \'inactive_sections' : {
    \  'lualine_a' : [  ],
    \  'lualine_b' : [  ],
    \  'lualine_c' : [ 'filename' ],
    \  'lualine_x' : [ 'location' ],
    \  'lualine_y' : [  ],
    \  'lualine_z' : [  ],
    \},
    \'extensions' : [ 'fzf' ],
    \}


""" MY BINDINGS

let mapleader='\'
set timeout timeoutlen=1000 ttimeoutlen=10


noremap <leader>q :q!<cr>
nnoremap <leader>w :w<cr>
inoremap <leader>w <C-c>:w<cr>

imap jk <Esc>

no J }
no K {
no H ^
no L $

" autocentering
nnoremap { }zz
nnoremap } {zz

" move viewport to the right/left
nnoremap zL 10zl
nnoremap zH 10zh


" " Remap for dealing with word wrap
" nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
" nnoremap <expr> j v:count == 0 ? 'gj' : 'j'


" Redo with U instead of Ctrl+R
nnoremap U <C-R>


" arrow keys to move lines
" nnoremap g] ddkP
" vnoremap g] :m '<-2<CR>gv=gv
" vnoremap g[ :m '>+1<CR>gv=gv
" nnoremap g[ ddp
nnoremap <up> ddkP
vnoremap <up> :m '<-2<CR>gv=gv
vnoremap <down> :m '>+1<CR>gv=gv
nnoremap <down> ddp

" add newline without insert
nmap go o<ESC>k
nmap gO O<ESC>j


" spellcheck
map gz :setlocal spell! spelllang=en_us,es<CR>
map gZ :set nospell<CR>



" make vim remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif



""" hop
nmap s :HopChar1<CR>
nmap S :HopChar2<CR>
" nmap x :HopPattern<CR>
" nmap s :HopWord<CR>
" nmap F :HopLine<CR>




"""""" MOVEMENT

" disable these
map <C-e> <Nop> " scroll the window downwards.
map <C-u> <Nop> " move your cursor upward half a screen.
map <C-d> <Nop> " move your cursordownward half a screen.



""" BUFFERS
" nnoremap <leader>n :Buffers<CR>
nnoremap <C-n> :bn<CR>
nnoremap <C-b> :bp<CR>
" noremap <C-x> :bdelete<CR>
nnoremap <C-x> :Bdelete<CR>


""" WINDOWS
set splitbelow
set splitright

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

nnoremap <leader>S <C-w>s
nnoremap <leader>s <C-w>v

nnoremap <leader>r <C-w>r  " rotate the windows
nnoremap <leader>e <C-w>x  " exchange with next window
nnoremap <leader>= <C-w>=  " reset all windows
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>_ :vertical resize -5<CR>
nnoremap <leader>> :resize +5<CR>
nnoremap <leader>< :resize -5<CR>


""" TABS
" nnoremap <leader>m gt
" nnoremap <leader>M gT
" nnoremap <leader>t :tabnew<cr>




""" SPACING

set expandtab      " TAB is expanded into spaces
set shiftwidth=4   " num space characters for indent
set tabstop=4      " num space characters for TAB key
set softtabstop=4

set autoindent
set smartindent
set breakindent
set backspace=indent,eol,start " change backspace to behave more intuitively
set backspace=2
set linespace=0


""" indenting
let g:indent_blankline_char = '¦'
 " let g:indent_blankline_space_char = ' '
" let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_char_highlight_list = ['NonText']


""" normal tabbing with TAB key
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv


""" easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


""" better whitespace
let g:better_whitespace_ctermcolor='darkgray'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0





"""""" SEARCHING

set hlsearch 	    " highligh matched search terms
set incsearch       " start searching as you type letters
set ignorecase      " make searches case sensitive
set smartcase       " will search case sensitive if uppercase present, needs ignorecase set

noremap <BS> :noh<CR>   " clear search highlight



""" FZF fuzzy finder

nmap <leader>r :Files<CR>
nmap <leader>e :Rg<CR>
" nmap <leader>r :Files<CR>

    " \ 'ctrl-q': function('s:build_quickfix_list'),
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-S': 'split',
    \ 'ctrl-s': 'vsplit' }


" let g:fzf_layout = { 'down': '~30%' }
" let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6, 'highlight': 'Comment' } }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

" " Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }





""" TREE view

nnoremap <leader>m :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>

" You can disable default mappings with
" " let nvim_tree_disable_keybindings=1

let g:nvim_tree_side = 'left' " or right
let g:nvim_tree_width = 30 "30 by default
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 0 "0 by default, closes the tree when it's the last window
" let g:nvim_tree_auto_ignore_ft = {'startify', 'dashboard'} "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 0 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 0 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 0 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 0 "0 by default, will not resize the tree when opening a file
let g:nvim_tree_disable_netrw = 1 "1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)

let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '~',
    \ 'git': {
    \   'unstaged': "×",
    \   'staged': "➜",
    \   'unmerged': "",
    \   'renamed': "",
    \   'untracked': ""
    \   },
    \ 'folder': {
    \   'default': "◼",
    \   'open': "┌",
    \   'empty': "-",
    \   'empty_open': "-",
    \   'symlink': "~",
    \   }
    \ }






""" LSP Language Server Protocol

nnoremap <silent> ]d         <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> [d         <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <silent> <leader>e  <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

nnoremap <silent> <leader>d  <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>D  <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>h  <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <leader>d  <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <leader>d  <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <leader>H  <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <leader>k  <cmd>lua vim.lsp.buf.type_definition()<CR>




" treesitter folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()


" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect   " Set completeopt to have a better completion experience
set shortmess+=c                            " Avoid showing message extra message when using completion

let g:completion_enable_auto_hover = 1           " enable/disable when navigating through completion items, LSP's hover is automatically called and displays in a floating window
let g:completion_enable_auto_signature = 1       " enable/disable signature help opens automatically whenever it's available
let g:completion_sorting = "none"                " how your items being sorted in the popup menu. possible value: length, alphabet, none

" let g:completion_matching_smart_case = 1       " specify a list of matching strategy, assign priority from high to low. For example
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']

let g:completion_trigger_character = ['.', '::'] " additional trigger character, default is gien by your language server
" let g:completion_trigger_on_delete = 1         " enable trigger completion on delete
" let g:completion_timer_cycle = 200             " default value is 80 timer to control the rate of completion

let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['tabnine', 'lsp']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
\}

let g:completion_tabnine_max_num_results=5 " max tabnine completion options
let g:completion_tabnine_sort_by_details=1 " sort by tabnine score (default: 0)
let g:completion_tabnine_max_lines=1000 " max line for input. from current line -1000 ~ +1000 lines is passed as input






""" TERMINAL

" Maps ESC to exit terminal's insert mode
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <leader>q  <C-\><C-n>
endif

" open a new tab window
nnoremap <C-\>t :tabnew +terminal<CR>
tnoremap <C-\>t <C-\><C-n>:tabnew +terminal<CR>

" open a new horizontal split with a terminal
nnoremap <C-\>S :new +terminal<CR>
tnoremap <C-\>S <C-\><C-n>:new +terminal<CR>

" open a new vertical split with a terminal
nnoremap <C-\>s :vnew +terminal<CR>
tnoremap <C-\>s <C-\><C-n>:vnew +terminal<cr>


augroup startup
	autocmd!
	" avoid nesting by adding a buffer to the existing vim session (credit justinmk)
	autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
		\ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
		\ |let g:f=fnameescape(expand('%:p'))
		\ |noau bwipe
		\ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
		\ |call rpcrequest(g:r, "nvim_command", "call lib#SetNumberDisplay()")
		\ |qa
		\ |endif
augroup END

augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
augroup END

" " When in terminal mode, when I change directory (cd), I would like vim to also change its working directory (:cd). You can do so by adding this in your .zshrc or .bashrc:
" #!/usr/bin/sh
" function cd() {
"   builtin cd "$@";
"   # if the parent process is nvim, do a vim cd
"   (ps -o comm= $PPID | grep nvim > /dev/null) && vmux-send :cd "$@"
" }
" export cd

:lua require('init')

