set -o emacs
# disable freezing of term ^S ^Q
stty start ""
stty stop ""
# hacks to remap term shortcuts
stty kill "^U"
stty werase "^Q"


### EXPORTS

export EDITOR=nvim
export VISUAL=nvim

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs --vimgrep --glob=\!.git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

export EXA_COLORS='ur=33:uw=33:ux=33:ue=33:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:xa=0:uu=0:un=31:gu=0:gn=31:da=36:sn=32:sb=32:lc=0:hd=30;47;01'


### ALIASES
alias vial='appimage-run /home/nan/Downloads/Vial-v0.4.1-x86_64.AppImage'

alias ls='exa'
alias ll='exa -l --links'
alias la='exa -l --links -a'
alias latree='exa -l --links -a --tree --level=3'
alias lasize='exa -l --links -a --sort=size'
alias lamodified='exa -l --links -a --sort=modified'

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
alias v='nvim'
alias vv='nvim $(fzf) -u .config/nvim/init.lua'

alias vconfig='nvim ~/.config/nvim/init.lua'
alias vscheme='nvim ~/.config/nvim/colors/mscheme.vim'
alias vlua='nvim ~/.config/nvim/lua/init.lua'
alias vbash='nvim ~/.bash_aliases'
alias vmonad='nvim ~/.xmonad/xmonad.hs'

alias nconfig='sudo vim /etc/nixos/configuration.nix'
alias nre='sudo nixos-rebuild switch'
alias nup='sudo nixos-rebuild switch --upgrade'

alias newnix='nix-shell -p "builtins.storePath /nix/store/f6iisy5i007yxaygdxg0pwdbpvpn794i-nix-2.4pre-rc1"'

alias neofetch='neofetch --ascii_distro nixos_old --color_blocks off'
alias icat='kitty +kitten icat --place=40x40@132x0'
alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias diff='patdiff'
alias ncm='ncmpcpp -b ~/.config/ncmpcpp/bindings'

alias gs='git status'

alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'
alias grit='/usr/bin/grit'

alias awkplot='awk -f .scripts/plot.awk | rsvg-convert -f png -z 2.0 | kitty +kitten icat --align left'
alias awkplotu='awk -f .scripts/plot.awk'
alias hledgerplot="sed 's/.*|| *//' | awk '!(NR==1||NR==2||NR==4)' | tr -d \&- | cut -f 2- -d ' ' | sed 's/|/ /g'"

alias pretty_error='xclip -o | xargs -0 echo -e'
alias pretty_csv='sed "s/\"//g"| column -t -s,'

alias colors='~/.scripts/colors.sh'


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
