PROMPT='%F{240}%~ %(?.%F{green}>.%F{red}>) %f'

source ~/.bash_aliases

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


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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

