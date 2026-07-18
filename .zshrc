### ZSH CONFIG

export EDITOR=vi
export VISUAL=nvim

export COLORTERM=truecolor
export CLICOLOR=1

# Enable substitution in the prompt.
setopt prompt_subst
setopt autocd autopushd

# command history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.history"
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt share_history
setopt append_history
setopt inc_append_history

# enable tab completion
autoload -U compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu yes select
bindkey '^N' menu-select

# auto cd folder
unsetopt autocd

# Ctrl+p/n for history navigation
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

# Ctrl+w/b for word jumping
bindkey "^W" forward-word
bindkey "^B" backward-word

# Ctrl+h for deleting last word backward-kill-word
bindkey '\x08' backward-kill-word

# terminal options
set -o emacs

# disable freezing of term ^S ^Q
stty start ""
stty stop ""


### PROMPT
RED='%F{red}'
GREEN='%F{green}'
G1='%F{240}'
G0='%F{245}'

# Config for prompt. PS1 synonym.
PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) %f"

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


eval "$(/opt/homebrew/bin/brew shellenv)"


# ABBREVIATIONS

# fish style abbreviations
source ~/.bin/fish

abbrev-alias g='git'
abbrev-alias gs='git status'
abbrev-alias gd='git diff'
abbrev-alias gl='git log'
abbrev-alias ga='git add'


### ALIASES

alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'

alias ..='cd ..'
alias cd..='cd ..'


if command -v eza &> /dev/null; then
    export EZA_CONFIG_DIR="$HOME/.config/eza"
    alias ls="eza --color=auto --icons=never --sort=name"
    alias la="eza -la --color=auto --icons=never --sort=name"
fi

if command -v bat &>/dev/null; then
    alias cat='bat'
fi

alias cube='cd ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/cube'

alias p='python3'
alias v='nvim'

siri() {
  pi -p --model zai/glm-5-turbo "$*"
}

# Skim
export SKIM_DEFAULT_COMMAND="rg --files --hidden"
export SKIM_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND"
export SKIM_OPTIONS_FILE="$HOME/.config/skim/config"

# official skim zsh completion and key bindings (Ctrl-T/Ctrl-R/Alt-C)
if command -v sk >/dev/null 2>&1; then
    source <(sk --shell zsh --shell-bindings)
fi

export PATH="/Users/nan/.bin:$PATH"
