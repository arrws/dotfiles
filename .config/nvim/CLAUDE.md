# CLAUDE.md

Neovim 0.12+ configuration using native `vim.pack` package manager.

## Architecture

```
.config/nvim/
├── init.lua                # Entry: loads opts → theme → keymaps → plugins/*
├── lua/
│   ├── opts.lua           # Core vim options
│   ├── keymaps.lua        # Global keymaps (leader = ;)
│   ├── plugins/           # Auto-loaded plugin configs
│   │   ├── ide.lua        # LSP, completion, formatter, treesitter
│   │   ├── telescope.lua  # Fuzzy finder (lazy-loaded)
│   │   ├── tree.lua       # File explorer
│   │   ├── mini.lua       # Mini.nvim modules
│   │   ├── copilot.lua    # GitHub Copilot
│   │   ├── lualine.lua    # Statusline
│   │   └── marks.lua      # Visual marks
│   └── xtheme/            # Custom theme
│       ├── colors.lua     # Color palette
│       ├── init.lua       # Highlight groups
│       └── line.lua       # Lualine theme
└── .stylua.toml           # Formatter config
```

## Performance Optimizations

- **Lazy Loading**: Plugins initialize on first use (LSP, Telescope, Mini modules)
- **Cached Setup**: Guards prevent duplicate initialization
- **Local Variables**: No global pollution
- **Theme Caching**: Colors loaded once per session

## Plugin Management

```lua
vim.pack.update()                    -- Update plugins
vim.pack.del({ "plugin-name" })      -- Remove plugin
vim.pack.update({ clean = true })    -- Clean orphans
```

After updating plugins, you may need to rebuild blink.cmp and telescope-fzf-native components if they were updated.

## Post-Install

```bash
# Build completion fuzzy matcher
cd ~/.local/share/nvim/site/pack/core/opt/blink.cmp
cargo build --release

# Install treesitter parsers
:TSInstall diff
```

## LSP Servers

- `pyright` - Python
- `rust_analyzer` - Rust
- `lua_ls` - Lua
- `ruff` - Python linting

## Formatters

- **Lua**: stylua
- **Python**: ruff_fix, ruff_format
- **Rust**: rustfmt
- **Fallback**: trim_whitespace

## Maintenance Tips

1. **Adding Plugins**: Add to appropriate `lua/plugins/*.lua` with `vim.pack.add`
3. **Keymaps**: Define in `keymaps.lua` or within plugin configs
4. **Theme Changes**: Modify `lua/xtheme/colors.lua` palette
5. **LSP Additions**: Add to servers list in `lua/plugins/ide.lua`


## Neovim Installation

### Latest Development Build (macOS ARM64)

To get the latest Neovim features and fixes:

```bash
# Download latest nightly build
curl -L -o nvim-macos-arm64.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz

# Remove quarantine attributes (avoids "unknown developer" warning)
xattr -c ./nvim-macos-arm64.tar.gz

# Extract archive
tar xzvf nvim-macos-arm64.tar.gz

# Install to /tmp (or move to preferred location)
rm -rf /tmp/nvim-macos-arm64 && mv nvim-macos-arm64 /tmp/

# Clean up
rm nvim-macos-arm64.tar.gz

# Run nvim
/tmp/nvim-macos-arm64/bin/nvim
```

For permanent installation, move to `/usr/local/` or `/opt/` and update your PATH.

## LSP Server Installation

This configuration uses nvim-lspconfig with the following servers:
```bash
npm install -g pyright
pip install ruff
rustup component add rust-analyzer
brew install lua-language-server
```

## Post-Installation Setup

After first installation or plugin updates, some plugins need manual compilation:

### 1. Build blink.cmp fuzzy library
```bash
cd ~/.local/share/nvim/site/pack/core/opt/blink.cmp
cargo build --release
```

### 2. Build telescope-fzf-native
```bash
cd ~/.local/share/nvim/site/pack/packages/start/telescope-fzf-native.nvim
make
```

### 3. Install treesitter parsers
Open Neovim and run:
```vim
:TSInstall c cpp diff lua vim vimdoc query python rust sql bash yaml markdown markdown_inline regex ledger
```
