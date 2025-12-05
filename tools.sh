#!/usr/bin/env bash
set -euo pipefail

BIN_DIR="$HOME/.bin"
TMP_DIR=$(mktemp -d)

trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$BIN_DIR"

echo "Installing tools to $BIN_DIR..."

# ripgrep
echo "Downloading ripgrep..."
curl -L --progress-bar https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep-15.1.0-x86_64-unknown-linux-musl.tar.gz \
  -o "$TMP_DIR/ripgrep.tar.gz"
tar -xzf "$TMP_DIR/ripgrep.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR/ripgrep-15.1.0-x86_64-unknown-linux-musl/rg" "$BIN_DIR/"

# delta
echo "Downloading delta..."
curl -L --progress-bar https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-unknown-linux-gnu.tar.gz \
  -o "$TMP_DIR/delta.tar.gz"
tar -xzf "$TMP_DIR/delta.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR/delta-0.18.2-x86_64-unknown-linux-gnu/delta" "$BIN_DIR/"

# bat
echo "Downloading bat..."
curl -L --progress-bar https://github.com/sharkdp/bat/releases/download/v0.26.0/bat-v0.26.0-x86_64-unknown-linux-gnu.tar.gz \
  -o "$TMP_DIR/bat.tar.gz"
tar -xzf "$TMP_DIR/bat.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR/bat-v0.26.0-x86_64-unknown-linux-gnu/bat" "$BIN_DIR/"

# lsd
echo "Downloading lsd..."
curl -L --progress-bar https://github.com/lsd-rs/lsd/releases/download/v1.2.0/lsd-v1.2.0-x86_64-unknown-linux-gnu.tar.gz \
  -o "$TMP_DIR/lsd.tar.gz"
tar -xzf "$TMP_DIR/lsd.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR/lsd-v1.2.0-x86_64-unknown-linux-gnu/lsd" "$BIN_DIR/"

# fd
echo "Downloading fd..."
curl -L --progress-bar https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz \
  -o "$TMP_DIR/fd.tar.gz"
tar -xzf "$TMP_DIR/fd.tar.gz" -C "$TMP_DIR"
cp "$TMP_DIR/fd-v10.2.0-x86_64-unknown-linux-musl/fd" "$BIN_DIR/"

# blink.cmp
echo "Downloading blink.cmp..."
mkdir -p "$HOME/.local/lib"
curl -L --progress-bar https://github.com/Saghen/blink.cmp/releases/download/v1.7.0/x86_64-unknown-linux-gnu.so \
  -o "$HOME/.local/lib/blink_cmp_fuzzy.so"
# blink.cmp library installed to ~/.local/lib/blink_cmp_fuzzy.so
# Add to shell: export LD_LIBRARY_PATH=\"\$HOME/.local/lib:\$LD_LIBRARY_PATH\"

# zsh-static
echo "Downloading zsh-static..."
curl -L --progress-bar http://ftp.debian.org/debian/pool/main/z/zsh/zsh-static_5.9-4+b7_amd64.deb \
  -o "$TMP_DIR/zsh-static.deb"
ar p "$TMP_DIR/zsh-static.deb" data.tar.xz | tar xJ -C "$TMP_DIR" ./bin/zsh-static
cp "$TMP_DIR/bin/zsh-static" "$BIN_DIR/zsh"

# neovim
echo "Downloading neovim..."
curl -L --progress-bar https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage \
  -o "$TMP_DIR/nvim.appimage"
chmod +x "$TMP_DIR/nvim.appimage"
cp "$TMP_DIR/nvim.appimage" "$BIN_DIR/nvim"
# if no FUSE: extract with 'cd ~/.bin && ./nvim --appimage-extract' then use 'squashfs-root/usr/bin/nvim'


