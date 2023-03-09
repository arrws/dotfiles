# dotfiles

sudo apt install curl cmake rsync git

kitty:
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

xmonad:
sudo apt install xmonad libghc-xmonad-contrib-dev libghc-xmonad-dev suckless-tools

rust:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install exa fd-find ripgrep bat git-delta

rust-analyzer:
rustup component add rust-src
rustup component add rust-analyzer



fzf (don't add to dotfiles):
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

nvim needs cmake for fzf

:TSInstall rust python markdown bash lua nix proto


