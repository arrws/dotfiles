" set shell=/bin/bash
" set mouse=a

" to install vim-plug:
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" DEFX requires Python3.6.1+ (echo has("python3") to be 1), to install: pip3 install --user pynvim


" call plug#begin('~/.local/share/nvim/plugged')
call plug#begin('~/.config/nvim/bundle')

Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'                    " distraction free writting
Plug 'moll/vim-bbye'                        " close buffers without closing windows with :Bdelete


Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'                   " better char search jumping / minimal easy-motion


Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'kristijanhusak/defx-git'			    " git symbols for defx
Plug 'mhinz/vim-signify'                    " git symbols per line & hunks navigation
Plug 'tpope/vim-fugitive'                   " git commands


Plug 'tpope/vim-repeat'                     " enable . repeat for plugins
Plug 'tpope/vim-commentary'                 " bindings to comment stuff out
Plug 'jiangmiao/auto-pairs'                 " auto-complete parenthesis and other brackets
Plug 'tpope/vim-surround'                   " smart bindings to change surrounding elements
Plug 'godlygeek/tabular'                    " alligning text
Plug 'Yggdroot/indentLine'                  " display thin vertical lines at each indentation level
Plug 'ntpeters/vim-better-whitespace'       " for trailling whitespace


Plug 'zxqfl/tabnine-vim'                    " ml autocomplete
Plug 'ledger/vim-ledger'				    " for ledger file


""" vim & tmux integration
" Plug 'edkolev/tmuxline.vim'                 " tmux statusline theme generator
" Plug 'christoomey/vim-tmux-navigator'       " navigate seamlessly between vim and tmux splits
" Plug 'benmills/vimux'                       " lets you send input to tmux


Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " update the parsers on update



call plug#end()

set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" filetype on
" syntax on

set hidden              " can hide a buffer that was unsaved and thus work with multiple files
set nobackup
set noswapfile
set history=1000        " status line commands history
set showcmd             " show in status line the command you're typing
set laststatus=2        " status line
set cmdheight=1         " height status line
set wildmenu            " status line menu
set wildmode=full
set wildoptions=tagfile

set number " relativenumber
set numberwidth=1       " number column width
set ruler               " show current column in status bar right corner
set signcolumn=yes:1
" set signcolumn=number	" merge sign and numbers gutter golumns


set autoindent
set smartindent
set backspace=indent,eol,start
set backspace=2
set linespace=0

set cursorline          " highlight current line
set foldcolumn=1        " number of folds / nesting level (?) the width of the grey column on the left side
set showmatch           " show matching braces



""" lightline
colorscheme mscheme

" \ 'colorscheme': 'powerline',
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'gitbranch': '%{FugitiveHead()}'
      \ },
      \ }




""" vim-go

let g:go_doc_keywordprg_enabled = 0 " K is mapped by default to open Docs, disable that!
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 0 " too many colors
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1




""" MY BINDINGS

let mapleader='\'
set timeout timeoutlen=1000 ttimeoutlen=10

set splitbelow
set splitright

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

" Redo with U instead of Ctrl+R
nnoremap U <C-R>

"block mode
nnoremap <leader>v <C-v>

" arrow keys to move lines
nnoremap <up> ddkP
vnoremap <up> :m '<-2<CR>gv=gv
vnoremap <down> :m '>+1<CR>gv=gv
nnoremap <down> ddp

nnoremap ]e ddkP
vnoremap ]e :m '<-2<CR>gv=gv
vnoremap [e :m '>+1<CR>gv=gv
nnoremap [e ddp

" upper or lowercase
nmap [c gUiW
nmap ]c guiW

" add newline without insert
" nmap [<Space> o<ESC>k
" nmap ]<Space> O<ESC>j
nmap go o<ESC>k
nmap gO O<ESC>j


" spellcheck
map [z :setlocal spell! spelllang=en_us,es<CR>
map ]z :set nospell<CR>


" " journaling
" nnoremap <leader>` "=strftime("> %l:%M %p")<CR>Po
" nnoremap <leader>~ "=strftime("### %a %d %b")

" make vim remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif








"""""" MOVEMENT

map <C-e> <Nop> " scroll the window downwards.
map <C-u> <Nop> " move your cursor upward half a screen.
map <C-d> <Nop> " move your cursordownward half a screen.



" window management
nnoremap <C-J> <C-w>j
nnoremap <C-K> <C-w>k
nnoremap <C-L> <C-w>l
nnoremap <C-H> <C-w>h

" splitting
nnoremap <leader>S <C-w>s
nnoremap <leader>s <C-w>v
" nnoremap <leader>r <C-w>r



" " buffers management
" noremap <leader>n :bnext<CR>
" noremap <leader>N :bprev<CR>
" noremap <leader>x :bdelete<CR>
" noremap <C-n> :bnext<CR>
" noremap <C-p> :bprev<CR>
" noremap <C-x> :bdelete<CR>


" " tabs management
" nnoremap <leader>m gt
" nnoremap <leader>M gT
" nnoremap <leader>t :tabnew<cr>



"""""" INDENTING

let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

""" normal tabbing with TAB key
nnoremap <TAB> >>
nnoremap <S-TAB> <<
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" set noexpandtab  " TAB is tab
set expandtab      " to insert spaces at TAB key
set shiftwidth=4   " num space characters for indent
set tabstop=4      " num space characters for TAB key

""" vim tabular
nmap <Leader>a :Tabularize /

""" better whitespace
let g:better_whitespace_ctermcolor='darkgray'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=0


"""""" SEARCHING

set hlsearch 	" highligh matched search terms
set incsearch   " start searching as you type letters
set ignorecase  " make searches case sensitive
set smartcase   " will search case sensitive if uppercase present, needs ignorecase set

noremap <BS> :noh<CR>   " clear search highlight



""" FZF fuzzy finder

nmap <C-r> :FZF<CR>
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~50%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible







"""""" DEFX

nnoremap <leader>m :Defx -toggle -split=vertical -winwidth=25 -direction=topleft -columns=git:indent:icon:filename<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> y               defx#do_action('copy')
    nnoremap <silent><buffer><expr> d               defx#do_action('move')
    nnoremap <silent><buffer><expr> D               defx#do_action('remove')
    nnoremap <silent><buffer><expr> r               defx#do_action('rename')
    nnoremap <silent><buffer><expr> p               defx#do_action('paste')
    nnoremap <silent><buffer><expr> <Space>         defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> j               line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k               line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> l               defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> L               defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> o               defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> C               defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> c               defx#do_action('new_file')
    nnoremap <silent><buffer><expr> !               defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> z               defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> R               defx#do_action('redraw')
    " nnoremap <silent><buffer><expr> <leader>m       defx#do_action('quit')
endfunction

call defx#custom#column('icon', {
    \ 'directory_icon': '+',
    \ 'opened_icon': '-',
    \ 'root_icon': ' ',
    \ })

call defx#custom#column('git', 'indicators', {
    \ 'Modified'  : '*',
    \ 'Staged'    : '➜',
    \ 'Untracked' : ' ',
    \ 'Renamed'   : '*',
    \ 'Unmerged'  : '═',
    \ 'Ignored'   : ' ',
    \ 'Deleted'   : 'x',
    \ 'Unknown'   : ' '
    \ })



""" git signify

" " Faster sign updates on CursorHold/CursorHoldI
" set updatetime=100
nnoremap <leader>gd :SignifyDiff<cr>
nnoremap <leader>gp :SignifyHunkDiff<cr>
nnoremap <leader>gu :SignifyHunkUndo<cr>

" hunk jumping
nmap <leader>g[ <plug>(signify-next-hunk)
nmap <leader>g] <plug>(signify-prev-hunk)


highlight SignifySignAdd    ctermfg=green   ctermbg=black
highlight SignifySignDelete ctermfg=red     ctermbg=black
highlight SignifySignChange ctermfg=yellow  ctermbg=black



" " vim & tmux integration
" map <Leader>t :VimuxPromptCommand<CR>	" Prompt for a command to run
" map <Leader>[ :VimuxInspectRunner<CR> 	" Inspect runner pane
" map <Leader>z :VimuxZoomRunner<CR>		" Zoom the tmux runner pane



""" Language Server Protocol

" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" nnoremap <silent>gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>


" treesitter folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

lua << EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.hls.setup{}
require'lspconfig'.pyls.setup{}
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF



