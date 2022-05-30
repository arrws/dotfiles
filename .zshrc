
# Enable substitution in the prompt.
setopt prompt_subst
setopt autocd autopushd


export CLICOLOR=1
export COLORTERM="truecolor"

# History
export HISTSIZE=1000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history


# tab completion
autoload -Uz compinit && compinit

# autocomplete tab show options doubletab fill
zstyle ':completion:*' menu yes select


bindkey '^Q' backward-kill-word
bindkey '^W' forward-word
bindkey '^B' backward-word
# bindkey "^0"   beginning-of-line
# bindkey "^4"   end-of-line


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

# ### if non-zero, prints last exit code
# colored_exit_code() {
#   echo "%(?..${nl}%F{8}exit %F{1}%?)%f"
# }


# Config for prompt. PS1 synonym.
# PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) $(colored_exit_code) %f"
PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) %f"
RPROMPT="$G2%D{%H:%M:%S}"


export TERM=xterm-256color
export PATH="$PATH:/home/nan/.scripts"


### bash aliases
source ~/.bash_aliases


### fish abbreviations

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

### abbreviations

# git
abbrev-alias gs='git status'
abbrev-alias gd='git diff'
abbrev-alias gl='git log'
abbrev-alias gsp='git stash pop'
abbrev-alias gsl='git stash list'
abbrev-alias ga='git add'
abbrev-alias gc='git commit'
abbrev-alias gp='git push'
abbrev-alias gpf='git push --force'

# kubernetes
abbrev-alias k='kubectl'
abbrev-alias kg='kubectl get'
abbrev-alias kgp='kubectl get pods'
abbrev-alias kgd='kubectl get deployments'
abbrev-alias kgpg='kubectl get pods | rg'
abbrev-alias kd='kubectl describe'
abbrev-alias kdp='kubectl describe pod'
abbrev-alias kdd='kubectl describe deployment'
abbrev-alias kl='kubectl logs'

# nix
abbrev-alias nup='sudo nixos-rebuild switch --upgrade'
abbrev-alias nre='sudo nixos-rebuild switch'


# kubectl autocomplete
source <(kubectl completion zsh)

# zoxide setup
source .zoxide
