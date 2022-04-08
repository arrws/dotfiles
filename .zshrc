
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
zstyle ':completion:*' menu no select


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

# Config for prompt. PS1 synonym.
PROMPT="$G1%~ "'$(git_branch_name)'"%(?.$GREEN>.$RED>) %f"
RPROMPT="$G2%D{%H:%M:%S}"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -n "${commands[fzf-share]}" ]; then
    source "$(fzf-share)/key-bindings.zsh"
    source "$(fzf-share)/completion.zsh"
fi


source ~/.bash_aliases

export PATH="$PATH:/home/nan/.scripts"

