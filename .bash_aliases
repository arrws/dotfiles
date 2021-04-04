set -o vi
export EDITOR=nvim
export VISUAL=nvim

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob '"'"'!.git/'"'"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'



alias la='ls -Flah'
alias cp="cp -Riv"
alias mv="mv -iv"
alias rm='rm -riv'
alias mkdir='mkdir -p'
alias tree='tree -F'

md() { mkdir -p "$@" && builtin cd "$1"; }
cl() { builtin cd "$1" && ls; }
cll() { builtin cd "$1" && ls -l; }


alias ..='cd ..'
alias cd..='cd ..'
alias fuck='sudo $(history -p !!)'
alias cclear='printf "\033c"' # actually clear text from the terminal


alias nnn='vifm .'
alias v='nvim'
alias vv='nvim $(fzf)'
alias vconfig='nvim ~/.config/nvim/init.vim'
alias vscheme='nvim ~/.config/nvim/colors/mscheme.vim'

alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias diff='diff -u --color'

alias icat='kitty +kitten icat --place=40x40@132x0'

alias gs='git status'
alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'


alias nconfig='sudo vim /etc/nixos/configuration.nix'
alias nre='sudo nixos-rebuild switch'
alias nup='sudo nixos-rebuild switch --upgrade'

# Colored output in man pages
function man {
    LESS_TERMCAP_md=$'\e[38;5;219m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}


function tmx {
  name=$1
  if tmux list-sessions | grep -q "^${name}:"; then
    tmux attach -t "${name}"
  else
    tmux new-session -s "${name}"
  fi
}

alias colors='for i in {0..255}; do printf "\x1b[38;5;${i}m ███ colour${i}  \\\\e[38;5;${i}m\x1b[0m\n"; done;'
function grepcolor {
    printf "\x1b[38;5;$1m ███ colour$1  \\\\e[38;5;$1m\x1b[0m\n"
}


