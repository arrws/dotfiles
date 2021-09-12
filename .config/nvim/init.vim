" set shell=/bin/bash

" to install vim-plug:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


call plug#begin('~/.config/nvim/bundle')

Plug 'moll/vim-bbye'                                        " close buffers without closing windows with :Bdelete
Plug 'hoob3rt/lualine.nvim'                                 " lua statusline

Plug 'kyazdani42/nvim-tree.lua'                             " file explorer
Plug 'neovim/nvim-lspconfig'                                " for LSP help
Plug 'kabouzeid/nvim-lspinstall'                            " utility for installing lsp servers

Plug 'hrsh7th/nvim-cmp'                                     " LSP autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }        " ML autocomplete
Plug 'ray-x/cmp-treesitter'
Plug 'f3fora/cmp-spell'
Plug 'L3MON4D3/LuaSnip'                                     " Snippets plugin



Plug 'folke/which-key.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " LSP based syntax highlighting
Plug 'sbdchd/neoformat'                                     " auto formateer

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'                              " git signs for vertical bar

" Plug 'TimUntersberger/neogit'                               " git commands

Plug 'phaazon/hop.nvim'                                     " better easy-motion

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }         " fuzzy searcher
Plug 'junegunn/fzf.vim'                                     " fuzzy searcher helpers
Plug 'gfanto/fzf-lsp.nvim'                                  " use FZF for  displaying LSP searches
Plug 'ojroques/nvim-lspfuzzy'                               " integrate FZF with the LSP server

Plug 'junegunn/vim-easy-align'                              " alligning text
Plug 'tpope/vim-surround'                                   " smart bindings to change surrounding elements
Plug 'tpope/vim-repeat'                                     " enable . repeat for plugins
Plug 'tpope/vim-commentary'                                 " bindings to comment stuff out
Plug 'windwp/nvim-autopairs'                                " auto-complete parenthesis and other brackets
Plug 'AndrewRadev/linediff.vim'                             " :Linediff diff two blocks of text selected in visual mode
Plug 'AndrewRadev/splitjoin.vim'                            " reformat between single-line statement and a multi-line one
Plug 'glepnir/indent-guides.nvim'                           " display thin vertical lines at each indentation level
Plug 'ntpeters/vim-better-whitespace'                       " for trailling whitespace
Plug 'norcalli/nvim-colorizer.lua'                          " highlight colors

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
" set signcolumn=number	" merge sign and numbers gutter golumns
" set signcolumn=yes:1   " always show sign column
set signcolumn=auto:1   " sign column
set foldcolumn=0        " fold column width
set fillchars=vert:\│   " vertical bar delimiter

set cursorline          " highlight current line
set showmatch           " show matching braces

set undofile            " save undo history

set diffopt+=vertical


colorscheme mscheme


""" MY BINDINGS

let mapleader='\'
set timeout timeoutlen=1000 ttimeoutlen=10

" noremap <leader>a :source ~/.config/nvim/colors/mscheme.vim<cr>

noremap <leader>q :q!<cr>
nnoremap <leader>w :w<cr>
inoremap <leader>w <C-c>:w<cr>

noremap <leader>v <C-v>
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
" map <C-e> <Nop> " scroll the window downwards.
" map <C-u> <Nop> " move your cursor upward half a screen.
" map <C-d> <Nop> " move your cursordownward half a screen.



""" TABS

nnoremap <C-[> gt
nnoremap <C-]> gT
nnoremap <leader>t :tabnew<cr>

nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>



""" WINDOWS

set splitbelow
set splitright

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-T> <C-w>T


nnoremap <leader>S <C-w>s
nnoremap <leader>s <C-w>v

nnoremap <C-\>r <C-w>r  " rotate the windows
nnoremap <C-\>e <C-w>x  " exchange with next window
nnoremap <C-\>= <C-w>=  " reset all windows
nnoremap <C-\>l :vertical resize +5<CR>
nnoremap <C-\>h :vertical resize -5<CR>
nnoremap <C-\>j :resize +5<CR>
nnoremap <C-\>k :resize -5<CR>



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

""" BUFFERS
nnoremap <leader>n :bn<CR>
nnoremap <leader>b :bp<CR>
nnoremap <leader>x :Bdelete<CR>
" noremap <C-q> :bdelete<CR>







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




" yank until the end of line
nnoremap Y y$

" highlight on yank
augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end



"""""" SEARCHING

set hlsearch 	    " highligh matched search terms
set incsearch       " start searching as you type letters
set ignorecase      " make searches case sensitive
set smartcase       " will search case sensitive if uppercase present, needs ignorecase set

noremap <BS> :noh<CR>   " clear search highlight

set inccommand=nosplit " live visualization of substitutions


""" FZF fuzzy finder

command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, {'source': 'rg --files'}, <bang>0)

nmap <C-r> :HFiles<CR>
nmap <C-e> :Files<CR>
nmap <C-f> :Rg<CR>
nmap <C-b> :Buffers<CR>
" nmap <C-m> :Marks<CR>
nmap <C-c> :Commits<CR>

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

" make fzf obey your colorscheme
let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }


" so that it won't move cursor
nnoremap <SPACE> <Nop>




""" TREE view

nnoremap <C-m> :NvimTreeToggle<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
"
let g:nvim_tree_disable_default_keybindings = 1 " to disable default mappings
let g:nvim_tree_side = 'left'               " or right
let g:nvim_tree_width = 30                  " 30 by default
let g:nvim_tree_ignore = [ '.git', '.cache' ]
let g:nvim_tree_auto_open = 0               " 0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:nvim_tree_auto_close = 0              " 0 by default, closes the tree when it's the last window
                                            " let g:nvim_tree_auto_ignore_ft = {'startify', 'dashboard'} "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 0            " 0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 0                  " 0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1          " 0 by default, this option shows indent markers when folders are open
let g:nvim_tree_hide_dotfiles = 1           " 0 by default, this option hides files and folders starting with a dot `.`
let g:nvim_tree_git_hl = 0                  " 0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_root_folder_modifier = ':~' " This is the default. See :help filename-modifiers for more options
let g:nvim_tree_tab_open = 0                " 0 by default, will open the tree when entering a new tab and the tree was previously open
let g:nvim_tree_width_allow_resize  = 0     " 0 by default, will not resize the tree when opening a file
let g:nvim_tree_disable_netrw = 1           " 1 by default, disables netrw
let g:nvim_tree_hijack_netrw = 1            " 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
let g:nvim_tree_highlight_opened_files = 1  "0 by default, will enable folder and file icon highlight for opened files/directories.


let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ }

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




" treesitter folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()



""" Formatter

" auto format on save
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts, FormatWrite
augroup END


command! Format execute 'lua vim.lsp.buf.formatting()'






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
    " remap Escape to leave terminal mode
    autocmd TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
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

