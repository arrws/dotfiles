### BASH CONFIG (bash 5+)

export EDITOR=vi
export VISUAL=nvim
export TERM=xterm-256color

export CLICOLOR=1
export COLORTERM="truecolor"

export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTFILE="$HOME/.history"
export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTTIMEFORMAT="[%F %T] "

shopt -s histappend      # Append to history file, don't overwrite
shopt -s cmdhist         # Save multi-line commands as one history entry

# Shell options
set -o emacs
shopt -s autocd        # Auto cd without typing 'cd'
shopt -s cdspell       # Correct minor spelling errors in cd
shopt -s dirspell      # Correct directory spelling errors
shopt -s checkjobs     # Warn before exiting with jobs

# Disable freezing of terminal ^S ^Q
stty start ""
stty stop ""

# Tab completion
if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
  . /opt/homebrew/etc/profile.d/bash_completion.sh
fi

# Ctrl+p/n for history navigation
bind '"\C-p": previous-history'
bind '"\C-n": next-history'

# Ctrl+b for backward-word (Alt+f for forward-word in bash)
# Ctrl+w is not bindable to forward-word
bind '"\C-b": backward-word'


### PROMPT SETUP

RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
G1='\[\033[38;5;240m\]'
G0='\[\033[38;5;245m\]'
NC='\[\033[0m\]'  # No Color

# Git branch function (match zsh style)
git_branch() {
    local branch
    branch=$(git symbolic-ref HEAD 2>/dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [ -n "$branch" ]; then
        echo "${G1}[${G0}${branch}${G1}]${NC} "
    fi
}

# Exit status indicator
prompt_status() {
    local status=$?
    if [ $status -eq 0 ]; then
        echo "${GREEN}>${NC}"
    else
        echo "${RED}>${NC}"
    fi
}

# Set prompt (match zsh style: path [branch] > )
PROMPT_COMMAND='PS1="${G1}\w ${NC}$(git_branch)$(prompt_status) "'


### ALIASES

# git
alias g='git'
alias gs='git status'
alias gst='git stash'
alias gc='git checkout'
alias gd='git diff'
alias gl='git log'
alias ga='git add'

# ls -> eza
if command -v eza &>/dev/null; then
    alias l="eza --color=auto --icons=never --sort=name"
    alias ls="eza --color=auto --icons=never --sort=name"
    alias la="eza -la --color=auto --icons=never --sort=name"
fi

# cat -> bat
if command -v bat &>/dev/null; then
    export BAT_THEME="xtheme"
    alias cat='bat --paging never --decorations never'
fi

# core
alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'

cl() { builtin cd "$1" && ls; }
alias ..='cd ..'
alias cd..='cd ..'

help() { curl cheat.sh/$1; }

alias p='python3'
alias v='/Users/andr/Downloads/nvim-macos-arm64/bin/nvim'


### SKIM

export SKIM_DEFAULT_COMMAND="rg --files --hidden"
export SKIM_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND"
export SKIM_DEFAULT_OPTIONS="--height 40% --layout=reverse --case=smart --tiebreak=score,index --bind=ctrl-j:accept,ctrl-k:kill-line"

# Load skim bash bindings (Ctrl-T/Ctrl-R/Alt-C) - requires bash 4+
if command -v sk >/dev/null 2>&1; then
    source <(sk --shell bash --shell-bindings)
fi

export PATH="/Users/andr/.bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
