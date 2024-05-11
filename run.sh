#!/usr/bin/env bash

paths=(
".bin/"

".zshrc"
".gitconfig"

".config/kitty/"
".config/bat/"
".config/lsd/"

".config/nvim/"
".config/yazi/*.toml"
".config/neofetch/"

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

