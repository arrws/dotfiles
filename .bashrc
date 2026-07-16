### GREAT CONFIG

export EDITOR=vi
export VISUAL=nvim
export TERM=xterm-256color
export CLICOLOR=1
export COLORTERM=truecolor

export HISTSIZE=5000
export HISTFILESIZE=$HISTSIZE
export HISTFILE="$HOME/.history"
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.bin:$PATH"


# Editing and completion
set -o emacs
if [[ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
    source /opt/homebrew/etc/profile.d/bash_completion.sh
fi

# bind '"\C-p": previous-history'
# bind '"\C-n": next-history'
# bind '"\C-w": forward-word'
# bind '"\C-b": backward-word'
# bind '"\C-h": backward-kill-word'

# if [[ -t 0 ]]; then
#     stty start ""
#     stty stop ""
# fi

# Prompt: path [branch] >
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

# Git abbreviations (native aliases; Bash expands them when executed)
alias g='git'
alias gs='git status'
alias gst='git stash'
alias gc='git checkout'
alias gd='git diff'
alias gl='git log'
alias ga='git add'

# Core aliases
alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias cd..='cd ..'
alias la='ls -la'

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging never --decorations never --theme Nord'
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
