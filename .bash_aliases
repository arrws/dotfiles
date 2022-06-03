set -o emacs

# check shortcuts: stty -a
# disable freezing of term ^S ^Q
stty start ""
stty stop ""
# make ctrl-q backward kill word in bash
stty werase "^Q"

export EDITOR=nvim
export VISUAL=nvim


# FZF
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --no-ignore-vcs --vimgrep --glob=\!.git'
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
    # run fzf-share for path to default files
    if [[ "${0}" == "bash" ]]; then
        # source ~/.fzf.bash
        source ~/.fzf/key-bindings.bash
        source ~/.fzf/completion.bash
    else
        # source ~/.fzf.zsh
        source ~/.fzf/key-bindings.zsh
        source ~/.fzf/completion.zsh
    fi
fi


# via-keyboard needs this
export DISABLE_SUDO_PROMPT=1
# vial
alias vial='appimage-run /home/nan/Downloads/Vial-v0.5-x86_64.AppImage'


# ls -> exa
if command -v exa &> /dev/null; then
    export EXA_COLORS='ur=33:uw=33:ux=33:ue=33:gr=0:gw=0:gx=0:tr=0:tw=0:tx=0:xa=0:uu=0:un=31:gu=0:gn=31:da=36:sn=32:sb=32:lc=0:hd=30;47;01'
    alias l='exa'
    alias ll='exa -l --links'
    alias la='exa -l --links -a'
    alias latree='exa -l --links -a --tree --level=3'
    alias lasize='exa -l --links -a --sort=size'
    alias lamodified='exa -l --links -a --sort=modified'
fi

# cat -> bat
if command -v bat &>/dev/null; then
    alias cat='bat -p --paging=never'
    alias bat='bat --style=numbers,changes,rule'
fi

# core
alias cp='cp -Riv'
alias mv='mv -iv'
alias rm='rm -riv'
alias mkdir='mkdir -p'
d() { builtin cd "$1" && exa; }
alias ..='cd ..'
alias cd..='cd ..'

alias cclear='printf "\033c"' # actually clear text from the terminal

alias r='vifm .'
#alias v='nvim'
alias v='~/nvim.appimage'

# apps
# alias neofetch='neofetch --ascii_distro nixos_old --color_blocks off'
alias icat='kitty +kitten icat --place=40x40@132x0'
alias feh='feh --scale-down'
alias mupdf='mupdf-x11'
alias ncm='ncmpcpp -b ~/.config/ncmpcpp/bindings'
alias p='python3'
alias ghc='ghc -dynamic -no-keep-hi-files -no-keep-o-files -o o'

if command -v patdiff &> /dev/null; then
    alias diff='patdiff'
fi

alias pretty_error='xclip -o | xargs -0 echo -e'
alias pretty_csv='sed "s/\"//g"| column -t -s,'

function pretty {
    poetry run black "$1" && poetry run isort "$1" && poetry run flake8 "$1";
}

alias hledgerplot="sed 's/.*|| *//' | awk '!(NR==1||NR==2||NR==4)' | tr -d \&- | cut -f 2- -d ' ' | sed 's/|/ /g'"
alias awkplot='awk -f .scripts/plot.awk | rsvg-convert -f png -z 2.0 | kitty +kitten icat --align left'
alias colors='~/.scripts/colors.sh'

function help {
    rg "$*" -N ~/codex ~/help ~/Desktop/help
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

export PATH="$PATH:/home/nan/.scripts:/home/nan/.cargo/bin"
