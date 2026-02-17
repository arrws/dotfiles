### dotfiles

System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts
> overlaps ghostty cmd+\ and cmd+h
Menu Title: Show All Tabs
Menu Title: Hide Ghostty

Select All Applications to disabled everywhere
leave blank

brew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ghostty zsh sk rsync git lsd bat ripgrep fd sd curl git-delta htop neovim yt-dlp tree-sitter-cli
brew install --cask codex
```

rust:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

python:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

nodejs:
```bash
brew install node
```

lsp servers:
```bash
rustup component add rust-analyzer
npm install -g pyright
pip3 install --user ruff
```

bat:
```bash
bat cache --build
```

nvim:
```bash
:lua require("nvim-treesitter").install({"diff","vim","vimdoc","query","bash","c","cpp","lua","python","rust","haskell","sql","yaml","regex","markdown","markdown_inline","ledger"})
:lua vim.pack.update()
```
