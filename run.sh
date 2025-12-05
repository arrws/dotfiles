#!/usr/bin/env bash

paths=(
".bin/"

".zshrc"
".gitconfig"

".config/ghostty/config"
".config/lsd/config.yaml"
".config/bat/config"
".config/bat/themes/xtheme.tmTheme"

".config/nvim/lua/"
".config/nvim/init.lua"

".claude/commands/"
".claude/hooks/"
".claude/CLAUDE.md"
".claude/settings.json"

".skynet.png"
)

GITPWD=$(pwd)
cd $HOME && rsync -avR --del "${paths[@]}" $GITPWD && cd $GITPWD
echo "DONE"
