### ZSH CONFIG

export EDITOR=vi
export VISUAL=nvim
export TERM=xterm-256color

# Enable substitution in the prompt.
setopt prompt_subst
setopt autocd autopushd

export CLICOLOR=1
export COLORTERM="truecolor"

# command history
export HISTSIZE=5000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt share_history
setopt append_history
setopt inc_append_history

# tab completion
autoload -Uz compinit && compinit

# autocomplete tab show options doubletab fill
zmodload zsh/complist
zstyle ':completion:*' menu yes no-select interactive
bindkey '^N' menu-select

# auto cd folder
unsetopt autocd

# Ctrl+p/n for history navigation
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

# Ctrl+w/b for word jumping
bindkey "^W" forward-word
# bindkey "^B" backward-word

# Ctrl+h for deleting last word backward-kill-word
bindkey '\x08' backward-kill-word

### TERMINAL OPTIONS

set -o emacs

# disable freezing of term ^S ^Q
stty start ""
stty stop ""


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

# Config for prompt. PS1 synonym.
PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) %f"


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
    if [[ $LBUFFER =~ "^(${(j:|:)ealiases})\$" ]]; then
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
eval "$(/opt/homebrew/bin/brew shellenv)"

# git
abbrev-alias g='git'
abbrev-alias gs='git status'
abbrev-alias gst='git stash'
abbrev-alias gc='git checkout'
abbrev-alias gd='git diff'
abbrev-alias gl='git log'
abbrev-alias ga='git add'


### ALIASES

# ls -> lsd
if command -v lsd &> /dev/null; then
    alias l='lsd'
    alias ls='lsd'
    alias la='lsd -la'
fi

# cat -> bat
if command -v bat &>/dev/null; then
    export BAT_THEME="xtheme"
    # export BAT_THEME="Visual Studio Dark+"
    alias cat='bat --paging never --decorations never'
fi


# core
alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'

function cl { builtin cd "$1" && ls; }
alias ..='cd ..'
alias cd..='cd ..'


alias p='python3'


# FZF
export FZF_DEFAULT_COMMAND='rg --files --hidden' # --no-ignore-vcs --vimgrep --glob=\!.git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --bind=ctrl-j:accept,ctrl-k:kill-line'
eval "$(fzf --zsh)"

# help
# bindkey -s '^h' 'rg -NI . ~/codex/help | fzf^M'
# alias helpvim='bat ~/codex/vim*'
function help { curl cheat.sh/$1 }
