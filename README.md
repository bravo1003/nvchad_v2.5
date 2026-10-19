# Neovim config

My personal NvChad v2.5 setup, built on lazy.nvim, blink.cmp, nvim-treesitter (`main` branch), Snacks and Telescope.

## External dependencies

### Required

| Tool | Used for |
| --- | --- |
| [Neovim](https://github.com/neovim/neovim/releases) 0.12+ | nvim-treesitter `main` needs 0.12 or newer |
| git | lazy.nvim, gitsigns, diffview |
| A [Nerd Font](https://www.nerdfonts.com/) | Icons in the NvChad UI, file trees and pickers. Set it as your terminal font |
| C compiler and `make` | Building telescope-fzf-native and treesitter parsers |
| `curl`, `tar`, `unzip`, `gzip` | Treesitter parser downloads and Mason installs |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) 0.26.1+ | nvim-treesitter `main` compiles parsers with it. Don't install it from npm |
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) | Telescope live grep (`<leader>sg`, `<leader>sG`, `<leader>sw`) and Snacks pickers |
| [fd](https://github.com/sharkdp/fd) (`fd`) | Telescope find files (`<leader>sf`), which calls `fd` by name |
| Node.js and npm | Mason installs prettier, typescript-language-server, yaml-language-server and markdownlint with npm |
| Python 3 with `venv` | Mason installs jedi-language-server and yamllint with pip |
| Rust toolchain (rustup) | `rust-analyzer` and `rustfmt` for Rust, and `cargo` for installing the tools below |

### Optional

| Tool | Used for |
| --- | --- |
| [delta](https://github.com/dandavison/delta) | Code action preview (`<leader>la`) and the undo diff (`<leader>u`, which falls back to Snacks' own diff view without it) |
| [lazygit](https://github.com/jesseduffield/lazygit) | `<leader>gg` |
| [yazi](https://github.com/sxyazi/yazi) | `<C-y>` file manager |
| cppcheck | C/C++ diagnostics through none-ls |
| jq | JSON formatting (`<leader>lf`) |
| yarn | The markdown-preview.nvim build step |
| Go | gopls and goimports for Go. `gofmt` comes with Go |
| black, codespell | Python formatting, and spelling fixes on format for every filetype |
| GitHub Copilot subscription | Copilot completions in blink and Sidekick next edit suggestions |
| [Copilot CLI](https://github.com/github/copilot-cli) | Sidekick's CLI window (`<F1>`) |
| tmux | `<C-h/j/k/l>` moves between Neovim splits and tmux panes (vim-tmux-navigator; tmux needs the matching config) |
| xclip, xsel or wl-clipboard (Linux only) | The system clipboard (`clipboard=unnamedplus`). macOS has this built in |
| [Neovide](https://neovide.dev/) | Optional GUI. Its settings are in `lua/options.lua` |

## Installing the dependencies

### 1. Rust toolchain (cargo)

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup component add rust-analyzer rustfmt
```

The installer adds `~/.cargo/bin` to your `PATH`. Everything installed with `cargo install` below ends up there.

### 2. System packages

macOS:

```sh
xcode-select --install          # clang, make, git
brew install neovim python
brew install --cask font-jetbrains-mono-nerd-font
```

Debian/Ubuntu:

```sh
sudo apt install build-essential git curl unzip tar gzip python3 python3-venv
sudo apt install xclip          # or wl-clipboard on Wayland
```

On Linux, distro packages are often older than Neovim 0.12. Install Neovim from the [GitHub releases](https://github.com/neovim/neovim/releases) instead. To install a Nerd Font, download one from [nerdfonts.com](https://www.nerdfonts.com/font-downloads), unzip it into `~/.local/share/fonts` and run `fc-cache -f`.

### 3. CLI tools with cargo

```sh
cargo install ripgrep fd-find git-delta
cargo install --locked tree-sitter-cli
cargo install --locked yazi-fm yazi-cli   # optional, for <C-y>
```

The `fd-find` crate installs the binary as `fd`. If you install fd with apt instead, the binary is called `fdfind`, so link it to the name Telescope uses:

```sh
ln -s "$(command -v fdfind)" ~/.local/bin/fd
```

### 4. Node.js

[fnm](https://github.com/Schniz/fnm) is a Node version manager written in Rust, so it installs with cargo too:

```sh
cargo install fnm
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc   # or your shell's rc file
exec "$SHELL"
fnm install --lts
npm install -g yarn              # optional, for the markdown-preview.nvim build
npm install -g @github/copilot   # optional, Copilot CLI for Sidekick <F1>
```

### 5. Other tools

macOS:

```sh
brew install lazygit jq cppcheck
```

Debian/Ubuntu:

```sh
sudo apt install jq cppcheck
go install github.com/jesseduffield/lazygit@latest   # needs Go, or see the lazygit README
```

Optional Go and Python tooling. Install Go from [go.dev](https://go.dev/dl/) (or `brew install go`), then run this inside Neovim:

```vim
:MasonInstall gopls goimports black codespell
```

Mason puts these in its own folder and adds it to Neovim's `PATH`, so they don't need to be on your shell's `PATH`.

## First start

1. Put this repo at `~/.config/nvim`, or symlink it there.
2. Start `nvim`. lazy.nvim installs the plugins, and base46 compiles the theme.
3. Run `:MasonInstallAll`. It installs the LSP servers, formatters and linters listed under `mason.pkgs` in `lua/chadrc.lua`.
4. Treesitter parsers install on their own: the list in `lua/plugins/init.lua` installs at startup, and any other language installs the first time you open a file in it.
5. Optional: run `:Copilot auth` to sign in to GitHub Copilot.
6. Run `:checkhealth` to look for anything missing. The useful sections are `lazy`, `mason`, `nvim-treesitter`, `snacks` and `sidekick`.
