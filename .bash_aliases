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

alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias diff='diff -u --color'

alias icat='kitty +kitten icat --place=40x40@132x0'

alias gs='git status'
alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'


alias nre='sudo nixos-rebuild switch'
alias nup='sudo nixos-rebuild switch --upgrade'

# function tmx {
#   name=$1
#   if tmux list-sessions | grep -q "^${name}:"; then
#     tmux attach -t "${name}"
#   else
#     tmux new-session -s "${name}"
#   fi
# }

