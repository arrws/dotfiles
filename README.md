### dotfiles

System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts
> overlaps ghostty cmd+\ and cmd+h
Menu Title: Show All Tabs
Menu Title: Hide Ghostty

Select All Applications to disabled everywhere
leave blank

homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

!!! install:
```bash
brew install ghostty zsh rsync git lsd bat ripgrep fd sd curl git-delta htop neovim
```

rust:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

python:
```bash
cargo install --locked uv
```

nodejs:
```bash
brew install node
```

lsp servers:
```bash
rustup component add rust-analyzer 2>/dev/null || warn "rust-analyzer already installed"
npm install -g pyright 2>/dev/null || warn "pyright already installed"
pip3 install --user ruff 2>/dev/null || warn "ruff already installed"
```

bat:
```bash
bat cache --build
```

nvim:
```bash
cd "$PLUGIN_DIR/telescope-fzf-native.nvim" && make

BLINK_DIR="$HOME/.local/share/nvim/site/pack/core/opt/blink.cmp"
if [ ! -d "$BLINK_DIR" ]; then
    log "Building blink.cmp..."
    git clone --depth=1 https://github.com/Saghen/blink.cmp "$BLINK_DIR"
    cd "$BLINK_DIR" && cargo build --release
else
    log "blink.cmp already exists"
fi

nvim --headless "+TSInstallSync diff lua vim vimdoc query python rust bash yaml markdown markdown_inline" +qa 2>&1 || warn "Some Treesitter parsers may have failed"

:lua vim.pack.update()
```

zsh
```bash
# Set zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    log "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
else
    log "zsh is already the default shell"
fi
```
