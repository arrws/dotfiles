#!/usr/bin/env bash

paths=(
".bin/"

".bashrc"
".zshrc"
".zprofile"
".gitconfig"

".config/ghostty/config"
".config/bat/config"
".config/bat/themes/xtheme.tmTheme"
".config/karabiner/karabiner.json"
".config/nvim/lua/"
".config/nvim/plugin/"
".config/nvim/init.lua"

".pi/agent/agents/"
".pi/agent/extensions/"
".pi/agent/prompts/"
".pi/agent/themes/"
".pi/agent/settings.json"
".pi/agent/AGENTS.md"

".skynet.png"
)

GITPWD=$(pwd)
cd $HOME && rsync -avR --del "${paths[@]}" $GITPWD && cd $GITPWD
echo "DONE"
