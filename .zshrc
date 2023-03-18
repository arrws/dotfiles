### ZSH CONFIG

# Enable substitution in the prompt.
setopt prompt_subst
setopt autocd autopushd

export CLICOLOR=1
export COLORTERM="truecolor"

# command history
export HISTSIZE=1000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt share_history
setopt append_history
setopt inc_append_history

# # auto correction
# setopt correct
# setopt correct_all

# tab completion
autoload -Uz compinit && compinit

# autocomplete tab show options doubletab fill
zstyle ':completion:*' menu yes select

# hack for kitty ctrl-backspace
bindkey '^Q' backward-kill-word


### TERMINAL OPTIONS

set -o emacs

# disable freezing of term ^S ^Q
stty start ""
stty stop ""

export EDITOR=nvim
export VISUAL=nvim

export TERM=xterm-256color


### PROMPT SETUP

# Colors
RED='%F{red}'
GREEN='%F{green}'
G2='%F{235}'
G1='%F{240}'
G0='%F{245}'

# Find and set branch name var if in git repository.
function git_branch_name() {
    BRANCH=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $BRANCH == "" ]];
    then
        :
    else
        echo "[$G0$BRANCH$G1] "
    fi
}

# # if non-zero, prints last exit code
# colored_exit_code() {
#   echo "%(?..${nl}%F{8}exit %F{1}%?)%f"
# }

# Config for prompt. PS1 synonym.
# PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) $(colored_exit_code) %f"
PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) %f"
RPROMPT="$G2%D{%H:%M:%S}"


### FISH ABBREVIATIONS

# declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# write a function for adding an alias to the list mentioned above
function abbrev-alias() {
    alias $1
    ealiases+=(${1%%\=*})
}

# expand any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '             expand-ealias
bindkey '^ '            magic-space     # control-space to bypass completion
bindkey -M isearch " "  magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line


### ABBREVIATIONS

# git
abbrev-alias g='git'
abbrev-alias gs='git status'
abbrev-alias gst='git stash'
abbrev-alias gd='git diff'
abbrev-alias gl='git log'
abbrev-alias ga='git add'
abbrev-alias gc='git commit'
abbrev-alias gr='git reset'

# kubernetes
abbrev-alias k='kubectl'
abbrev-alias kg='kubectl get'
abbrev-alias kgp='kubectl get pods'
abbrev-alias kgd='kubectl get deployments'
abbrev-alias kd='kubectl describe'
abbrev-alias kdp='kubectl describe pod'
abbrev-alias kdd='kubectl describe deployment'
abbrev-alias kl='kubectl logs'
abbrev-alias kgpr='kubectl get pods | rg'

# nix
abbrev-alias nup='sudo nixos-rebuild switch --upgrade'
abbrev-alias nre='sudo nixos-rebuild switch'


### ALIASES

# ls -> exa
if command -v exa &> /dev/null; then
    export EXA_COLORS='ur=33:uw=33:ux=33:ue=33:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:xa=0:uu=0:un=31:gu=0:gn=31:da=36:sn=32:sb=32:lc=0:hd=30;47;01'
    alias l='exa'
    alias ls='exa'
    alias ll='exa -l --links'
    alias la='exa -l --links -a'
    alias latree='exa -l --links -a --tree --level=3'
    alias lasize='exa -l --links -a --sort=size'
    alias lamodified='exa -l --links -a --sort=modified'
fi

# cat -> bat
if command -v bat &>/dev/null; then
    alias cat='bat -p --paging=never'
fi

# core
alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'
d() { builtin cd "$1" && exa; }
alias ..='cd ..'
alias cd..='cd ..'
alias cl='printf "\033c"' # actually clear text from the terminal

# neovim
if test -f ~/nvim.appimage; then
    alias v='~/nvim.appimage'
else
    alias v='nvim'
fi

# apps
alias icat='kitty +kitten icat --place=40x40@132x0'
alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias r='vifm .'
alias n='ncmpcpp'
alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'

alias hledgerplot="sed 's/.*|| *//' | awk '!(NR==1||NR==2||NR==4)' | tr -d \&- | cut -f 2- -d ' ' | sed 's/|/ /g'"
alias awkplot='awk -f .scripts/plot.awk | rsvg-convert -f png -z 2.0 | kitty +kitten icat --align left'


# FZF

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs --vimgrep --glob=\!.git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --bind=ctrl-j:accept,ctrl-k:kill-line'
if command -v fzf-share &>/dev/null; then
    source "$(fzf-share)/key-bindings.zsh"
    source "$(fzf-share)/completion.zsh"
else
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi


# help
bindkey -s '^h' 'rg -NI . ~/codex/help | fzf^M'
# bindkey -s '^h' 'rg -NI . ~/codex/help | less^M'
function help { curl cheat.sh/$1 }

# colored calendar
function calx {
    cal -wym --color=always $@ | perl -p -E '
       sub col { "\033\[38;5;$_[0]m$1\033\[0m" }
       s/^(.\d)/col 241/ge;
       s/   \K( [2-9]|\d\d) /col(241).q( )/ge;
       /y|er/ && s/^(.+)$/col 12/ge;
       /Mo Tu/ && s/^(.+)$/col 6/ge'
}

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


# kubectl autocomplete
command -v kubectl &> /dev/null && source <(kubectl completion zsh)

alias pretty_error='xclip -o | xargs -0 echo -e'
alias pretty_csv='sed "s/\"//g"| column -t -s,'
function pretty {
    poetry run black "$1" && poetry run isort "$1" && poetry run flake8 "$1";
}

# vial
export DISABLE_SUDO_PROMPT=1 # via-keyboard needs this
alias vial='appimage-run /home/nan/Downloads/Vial-v0.5-x86_64.AppImage'


export PATH="$PATH:$HOME/.bin:$HOME/.cargo/bin"
