# dotfiles

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

brew install \
    rsync \
    git \
    lsd \
    bat \
    ripgrep \
    fd \
    sd \
    curl \
    git-delta \
    neovim \
    yazi \
    htop \
    jq \
    procs \
    gcc \
    make \
    util-linux \
    unzip \
    neofetch \
    ledger \
    cmatrix

bat cache --build

# in neovim
:TSInstall rust python markdown bash lua nix proto yaml ledger


