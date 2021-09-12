set -o vi
export EDITOR=nvim
export VISUAL=nvim

export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs --vimgrep --glob=\!.git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'

export EXA_COLORS='ur=33:uw=33:ux=33:ue=33:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:xa=0:uu=0:un=31:gu=0:gn=31:da=36:sn=32:sb=32:lc=0:hd=30;47;01'

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
alias vv='nvim $(fzf)'

alias vconfig='nvim ~/.config/nvim/init.vim'
alias vscheme='nvim ~/.config/nvim/colors/mscheme.vim'
alias vlua='nvim ~/.config/nvim/lua/init.lua'
alias vbash='nvim ~/.bash_aliases'
alias vmonad='nvim ~/.xmonad/xmonad.hs'

alias nconfig='sudo vim /etc/nixos/configuration.nix'
alias nre='sudo nixos-rebuild switch'
alias nup='sudo nixos-rebuild switch --upgrade'

alias neofetch='neofetch --ascii_distro nixos_old --color_blocks off'
alias icat='kitty +kitten icat --place=40x40@132x0'
alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias diff='patdiff'
alias ncm='ncmpcpp -b .config/ncmpcpp/bindings'

alias gs='git status'

alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'
alias grit='/usr/bin/grit'

alias awkplot='awk -f .scripts/plot.awk | rsvg-convert -f png -z 2.0 | kitty +kitten icat --align left'
alias awkplotu='awk -f .scripts/plot.awk'
alias hledgerplot="sed \"s/.*|| *//\" | awk '!(NR==1||NR==2||NR==4)' | tr -d \&- | cut -f 2- -d ' ' | sed 's/|/ /g'"


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

colorarr=( "#000000" "#800000" "#008000" "#808000" "#000080" "#800080" "#008080" "#c0c0c0" "#808080" "#ff0000" "#00ff00" "#ffff00" "#0000ff" "#ff00ff" "#00ffff" "#ffffff" "#000000" "#00005f" "#000087" "#0000af" "#0000d7" "#0000ff" "#005f00" "#005f5f" "#005f87" "#005faf" "#005fd7" "#005fff" "#008700" "#00875f" "#008787" "#0087af" "#0087d7" "#0087ff" "#00af00" "#00af5f" "#00af87" "#00afaf" "#00afd7" "#00afff" "#00d700" "#00d75f" "#00d787" "#00d7af" "#00d7d7" "#00d7ff" "#00ff00" "#00ff5f" "#00ff87" "#00ffaf" "#00ffd7" "#00ffff" "#5f0000" "#5f005f" "#5f0087" "#5f00af" "#5f00d7" "#5f00ff" "#5f5f00" "#5f5f5f" "#5f5f87" "#5f5faf" "#5f5fd7" "#5f5fff" "#5f8700" "#5f875f" "#5f8787" "#5f87af" "#5f87d7" "#5f87ff" "#5faf00" "#5faf5f" "#5faf87" "#5fafaf" "#5fafd7" "#5fafff" "#5fd700" "#5fd75f" "#5fd787" "#5fd7af" "#5fd7d7" "#5fd7ff" "#5fff00" "#5fff5f" "#5fff87" "#5fffaf" "#5fffd7" "#5fffff" "#870000" "#87005f" "#870087" "#8700af" "#8700d7" "#8700ff" "#875f00" "#875f5f" "#875f87" "#875faf" "#875fd7" "#875fff" "#878700" "#87875f" "#878787" "#8787af" "#8787d7" "#8787ff" "#87af00" "#87af5f" "#87af87" "#87afaf" "#87afd7" "#87afff" "#87d700" "#87d75f" "#87d787" "#87d7af" "#87d7d7" "#87d7ff" "#87ff00" "#87ff5f" "#87ff87" "#87ffaf" "#87ffd7" "#87ffff" "#af0000" "#af005f" "#af0087" "#af00af" "#af00d7" "#af00ff" "#af5f00" "#af5f5f" "#af5f87" "#af5faf" "#af5fd7" "#af5fff" "#af8700" "#af875f" "#af8787" "#af87af" "#af87d7" "#af87ff" "#afaf00" "#afaf5f" "#afaf87" "#afafaf" "#afafd7" "#afafff" "#afd700" "#afd75f" "#afd787" "#afd7af" "#afd7d7" "#afd7ff" "#afff00" "#afff5f" "#afff87" "#afffaf" "#afffd7" "#afffff" "#d70000" "#d7005f" "#d70087" "#d700af" "#d700d7" "#d700ff" "#d75f00" "#d75f5f" "#d75f87" "#d75faf" "#d75fd7" "#d75fff" "#d78700" "#d7875f" "#d78787" "#d787af" "#d787d7" "#d787ff" "#d7af00" "#d7af5f" "#d7af87" "#d7afaf" "#d7afd7" "#d7afff" "#d7d700" "#d7d75f" "#d7d787" "#d7d7af" "#d7d7d7" "#d7d7ff" "#d7ff00" "#d7ff5f" "#d7ff87" "#d7ffaf" "#d7ffd7" "#d7ffff" "#ff0000" "#ff005f" "#ff0087" "#ff00af" "#ff00d7" "#ff00ff" "#ff5f00" "#ff5f5f" "#ff5f87" "#ff5faf" "#ff5fd7" "#ff5fff" "#ff8700" "#ff875f" "#ff8787" "#ff87af" "#ff87d7" "#ff87ff" "#ffaf00" "#ffaf5f" "#ffaf87" "#ffafaf" "#ffafd7" "#ffafff" "#ffd700" "#ffd75f" "#ffd787" "#ffd7af" "#ffd7d7" "#ffd7ff" "#ffff00" "#ffff5f" "#ffff87" "#ffffaf" "#ffffd7" "#ffffff" "#080808" "#121212" "#1c1c1c" "#262626" "#303030" "#3a3a3a" "#444444" "#4e4e4e" "#585858" "#626262" "#6c6c6c" "#767676" "#808080" "#8a8a8a" "#949494" "#9e9e9e" "#a8a8a8" "#b2b2b2" "#bcbcbc" "#c6c6c6" "#d0d0d0" "#dadada" "#e4e4e4" "#eeeeee" )

alias colors='for i in {0..255}; do printf "\x1b[38;5;${i}m ███  $i  ${colorarr[$i+1]}\n"; done;'
function grepcolor {
    printf "\x1b[38;5;$1m ███  $1  ${colorarr[$i+1]}  \\\e[38;5;$1m ... \\\x1b[0m\n"
}


