#!/usr/bin/env bash

paths=(
".bin/"

".bashrc"
".zshrc"
".gitconfig"

".config/ghostty/"
".config/bat/"

".config/karabiner/karabiner.json"

".config/nvim/lua/"
".config/nvim/plugin/"
".config/nvim/init.lua"

# ".skynet.png"
)

GITPWD=$(pwd)
cd $HOME && rsync -avR --delete "${paths[@]}" $GITPWD && cd $GITPWD
echo "DONE"
