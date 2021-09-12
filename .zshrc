source ~/.bash_aliases


# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '[%F{245}'$branch'%F{240}] '
  fi
}
# Enable substitution in the prompt.
setopt prompt_subst

# # Config for prompt. PS1 synonym.
PROMPT='%F{240}%~ $(git_branch_name)%(?.%F{green}>.%F{red}>) %f'



bindkey -s "jk" '\e'
bindkey "^n" up-line-or-history
bindkey "^b" down-line-or-history

export CLICOLOR=1
export COLORTERM="truecolor"

# History
export HISTSIZE=1000
export HISTFILE="$HOME/.history" 
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export PATH=$HOME/.toolbox/bin:$PATH


# Rationalize dot (... -> ../..)
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}

# Automatically expand dots
zle -N rationalise-dot
bindkey . rationalise-dot

