#!/usr/bin/env bash

# "/etc/nixos/configuration.nix"

paths=(
".bin/*.sh"

".zshrc"
".config/kitty/kitty.conf"

".config/nvim/colors/"
".config/nvim/init.vim"
".config/nvim/lua/"

".config/bat/themes/xtheme.tmTheme"
".config/bat/config"

".config/vifm/colors/xtheme.vifm"
".config/vifm/vifmrc"

".config/feh/keys"
".config/mpd/mpd.conf"
".config/mpv/input.conf"
".config/ncmpcpp/bindings"
".config/ncmpcpp/config"
".config/neofetch/config.conf"

".xmobarrc"
".xmonad/xmonad.hs"
# ".xmodmaprc"

# ".gitconfig"
".skynet.png"
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

