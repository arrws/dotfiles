set -o emacs

# check shortcuts: stty -a
# disable freezing of term ^S ^Q
stty start ""
stty stop ""
# make ctrl-q backward kill word in bash
stty werase "^Q"


### EXPORTS

export EDITOR=nvim
export VISUAL=nvim

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs --vimgrep --glob=\!.git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

export EXA_COLORS='ur=33:uw=33:ux=33:ue=33:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:xa=0:uu=0:un=31:gu=0:gn=31:da=36:sn=32:sb=32:lc=0:hd=30;47;01'


### ALIASES
alias vial='appimage-run /home/nan/Downloads/Vial-v0.4.1-x86_64.AppImage'

# ls to exa
alias ls='exa'
alias ll='exa -l --links'
alias la='exa -l --links -a'
alias latree='exa -l --links -a --tree --level=3'
alias lasize='exa -l --links -a --sort=size'
alias lamodified='exa -l --links -a --sort=modified'

# core
alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'
md() { mkdir -p "$@" && builtin cd "$1"; }
cl() { builtin cd "$1" && ls; }
cll() { builtin cd "$1" && ls -l; }
alias ..='cd ..'
alias cd..='cd ..'
alias cclear='printf "\033c"' # actually clear text from the terminal

alias top='htop'
alias r='vifm .'
alias v='/home/andreea/nvim.appimage'
#alias v='nvim'

# configs
alias config_v='nvim ~/.config/nvim/lua/init.lua'
alias config_b='nvim ~/.bash_aliases'
alias config_z='nvim ~/.zshrc'
alias config_m='nvim ~/.xmonad/xmonad.hs'
alias config_k='nvim ~/.config/kitty/kitty.conf'
alias config_n='sudo nvim /etc/nixos/configuration.nix'

# nix
alias nre='sudo nixos-rebuild switch'
alias nup='sudo nixos-rebuild switch --upgrade'
alias newnix='nix-shell -p "builtins.storePath /nix/store/f6iisy5i007yxaygdxg0pwdbpvpn794i-nix-2.4pre-rc1"'

# apps
alias neofetch='neofetch --ascii_distro nixos_old --color_blocks off'
alias icat='kitty +kitten icat --place=40x40@132x0'
alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias diff='patdiff'
alias ncm='ncmpcpp -b ~/.config/ncmpcpp/bindings'
alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'

# git
alias gs='git status'
alias gd='git diff'
alias gl='git diff'

# kubernetes
alias k='kubectl'
alias kd='kubectl describe pod'
alias kp='kubectl get pods'
alias kl='kubectl logs'

alias pretty_error='xclip -o | xargs -0 echo -e'
alias pretty_csv='sed "s/\"//g"| column -t -s,'
function pretty {
    poetry run black "$1" && poetry run isort "$1" && poetry run flake8 "$1";
}


alias awkplot='awk -f .scripts/plot.awk | rsvg-convert -f png -z 2.0 | kitty +kitten icat --align left'
alias awkplotu='awk -f .scripts/plot.awk'
alias hledgerplot="sed 's/.*|| *//' | awk '!(NR==1||NR==2||NR==4)' | tr -d \&- | cut -f 2- -d ' ' | sed 's/|/ /g'"
alias colors='~/.scripts/colors.sh'


# help='cat /home/andreea/Desktop/help | grep'
function help {
    rg "$*" ~/codex
}

function calx {
    cal -wym --color=always $@ | perl -p -E '
       sub col { "\033\[38;5;$_[0]m$1\033\[0m" }
       s/^(.\d)/col 241/ge;
       s/   \K( [2-9]|\d\d) /col(241).q( )/ge;
       /y|er/ && s/^(.+)$/col 12/ge;
       /Mo Tu/ && s/^(.+)$/col 6/ge'
}

# Colored output in man pages
function man {
    LESS_TERMCAP_md=$'\e[38;5;219m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

function tmx {
  name=$1
  if tmux list-sessions | grep -q "^${name}:"; then
    tmux attach -t "${name}"
  else
    tmux new-session -s "${name}"
  fi
}

export PATH="$PATH:/home/nan/.scripts:/home/nan/.cargo/bin"
