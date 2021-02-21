PROMPT='%F{240}%~ %(?.%F{green}>.%F{red}>) %f'

source ~/.bash_aliases

bindkey -s "jk" '\e'
bindkey "^n" up-line-or-history
bindkey "^b" down-line-or-history

export CLI=1


# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export PATH=$HOME/.toolbox/bin:$PATH
