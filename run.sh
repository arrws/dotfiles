#!/bin/sh

# "/etc/nixos/configuration.nix"

paths=(
".scripts"

".xmobarrc"
".xmonad/xmonad.hs"

".bashrc"
".bash_aliases"

".config/kitty/kitty.conf"

".config/fish/config.fish"
".config/fish/functions/"

".config/nvim/init.vim"
".config/nvim/lua/"
".config/nvim/colors/mscheme.vim"

".config/vifm/vifmrc"
".config/vifm/colors/Default.vifm"

".config/feh/keys"
".config/mpv/input.conf"
".config/mpd/mpd.conf"

".Xdefaults"
".tmux.conf"
".gitconfig"
".ghc/ghci.conf"
".borg.backup"
# ".skynet.png"
)

for item in "${paths[@]}"; do
    args="${args} ${item}"
done

if which fzf; then
    ok="$(echo -e 'Backup to git\nCopy to local ' | fzf | cut -c1)"
else
    echo -n "[B]ackup to git / [C]opy to local:"
    read -n 1 ok
fi
echo $ok
echo ""

if [[ "$ok" == "B" ]]; then
    GITPWD=$(pwd)
    cd $HOME && rsync -avR ${args} $GITPWD && cd $GITPWD
    echo "DONE"
elif [[ "$ok" == "C" ]]; then
    echo "to copy to local run:"
    echo "rsync -avR ${args} $HOME"
    # rsync -avR ${args} $HOME
fi

