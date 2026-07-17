### GREAT CONFIG

export EDITOR=vi
export VISUAL=nvim

export COLORTERM=truecolor

export HISTSIZE=5000
export HISTFILESIZE=$HISTSIZE
export HISTFILE="$HOME/.history"
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend

eval "$(/opt/homebrew/bin/brew shellenv)"


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

alias la='ls -la'

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
export SKIM_DEFAULT_OPTIONS="--height 40% --layout=reverse --case=smart --tiebreak=score,index --bind=ctrl-j:accept,ctrl-k:kill-line"

if command -v sk >/dev/null 2>&1; then
    source <(sk --shell bash --shell-bindings)
fi

export PATH="/Users/nan/.bin:$PATH"
