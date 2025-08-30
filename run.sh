#!/usr/bin/env bash

paths=(
".bin/"

".zshrc"
".gitconfig"

".config/kitty/kitty.conf"
".config/lsd/config.yaml"
".config/bat/config"
".config/bat/themes/xtheme.tmTheme"

".config/nvim/lua/"
".config/nvim/init.lua"
".config/nvim/CLAUDE.md"

".claude/commands/"
".claude/CLAUDE.md"
".claude/settings.json"

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
    cd $HOME && rsync -avR --del ${args} $GITPWD && cd $GITPWD
    echo "DONE"
elif [[ "$ok" == "C" ]]; then
    echo "to copy to local run:"
    echo "rsync -avR ${args} $HOME"
    # rsync -avR ${args} $HOME
fi

