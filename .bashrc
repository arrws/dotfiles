### GREAT CONFIG

export EDITOR=vi
export VISUAL=nvim

export COLORTERM=truecolor

export HISTSIZE=5000
export HISTFILESIZE=$HISTSIZE
export HISTFILE="$HOME/.history"
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend


# Editing and completion
set -o emacs
if [[ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
    source /opt/homebrew/etc/profile.d/bash_completion.sh
fi


# PROMPT
__prompt_command() {
    local status=$? branch color

    history -a
    history -n
    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null)
    [[ -n $branch ]] && branch="[\[\e[38;5;245m\]${branch}\[\e[38;5;240m\]] "
    (( status == 0 )) && color='\[\e[32m\]' || color='\[\e[31m\]'
    PS1="\[\e[38;5;240m\]\w ${branch}${color}> \[\e[0m\]"
}
PROMPT_COMMAND=__prompt_command


eval "$(/opt/homebrew/bin/brew shellenv)"


# ALIASES

alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias ga='git add'

alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'

alias ..='cd ..'
alias cd..='cd ..'

if command -v eza &>/dev/null; then
    export EZA_CONFIG_DIR="$HOME/.config/eza"
    alias ls="eza --color=auto --icons=never --sort=name"
    alias la="eza -la --color=auto --icons=never --sort=name"
fi

if command -v bat &>/dev/null; then
    alias cat='bat'
fi

alias p='python3'
alias v='nvim'

alias cube='cd ~/Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/cube'

siri() {
    pi -p --model zai/glm-5-turbo "$*"
}

# Skim
export SKIM_DEFAULT_COMMAND="rg --files --hidden"
export SKIM_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND"
export SKIM_OPTIONS_FILE="$HOME/.config/skim/config"

# official skim zsh completion and key bindings (Ctrl-T/Ctrl-R/Alt-C)
if command -v sk >/dev/null 2>&1; then
    source <(sk --shell bash --shell-bindings)
fi

export PATH="/Users/nan/.bin:$PATH"
