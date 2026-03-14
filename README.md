### dotfiles

System Settings -> Keyboard -> Keyboard Shortcuts -> App Shortcuts
> overlaps ghostty cmd+\ and cmd+h
Menu Title: Show All Tabs
Menu Title: Hide Ghostty

Select All Applications to disabled everywhere
leave blank

brew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install ghostty zsh rsync git curl htop neovim yt-dlp
brew install sk eza bat ripgrep fd sd git-delta tree-sitter-cli
brew install --cask codex
brew install --cask claude-code
brew install node
```

rust fallback:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
cargo install skim eza bat ripgrep fd-find sd git-delta tree-sitter-cli
```

python:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
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
