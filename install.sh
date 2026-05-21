#!/bin/bash

set -euo pipefail

source ./functions.sh

echo "install.sh starting"

# -----------------------------------------------------------------------------
# Homebrew setup
# -----------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
    echo "ERROR: Homebrew is not installed. Run make init first."
    exit 1
fi

confirm "Update homebrew? - Updates Homebrew itself and fetches the latest package metadata (formulae and casks) from the repositories. It does not upgrade any installed packages." && brew update

install_terminal_and_shell_packages() {
  brew install --cask ghostty           # terminal
  brew install --cask docker
  brew install --formula \
    jq \                                # JSON processor
    fzf \                               # Fast fuzzy finder for files, history, and processes
    tmux \                              # Terminal multiplexer for sessions, windows, and panes
    ffmpeg \                            # For media files
    tmuxinator \                        # Declarative configuration and launching of tmux sessions
    the_silver_searcher \               # Fast code-searching tool (ag) that respects .gitignore
    ripgrep \                           # Extremely fast recursive line search tool (rg)
    zsh-autosuggestions \               # Suggests commands as you type based on shell history
    zsh-syntax-highlighting \           # Syntax highlighting for commands in the Zsh shell
    zsh-completion \                    # Additional tab-completion functions for Zsh
    fd \                                # Fast and user-friendly alternative to find
    bat \                               # cat clone with syntax highlighting and Git integration
    pastel \                            # Command-line tool for generating and manipulating colors
    wget \                              # Command-line utility for downloading files from the web
    lazygit \                           # Terminal UI for Git operations
    imagemagick \                       # Images
    opencode \                          # opencode
    ghostscript \                       # Imagemagick dependency to render PDFs
    harper                              # Grammar and style checker for Markdown and plain text
}

install_editors_and_their_dependencies() {
  brew install --formula neovim        # Hyperextensible Vim-based text editor focused on extensibility and usability
  brew tap mesca/luarocks              # Add third-party Homebrew tap for LuaRocks packages
  brew install luarocks                # Lua package manager (used for managing Neovim Lua plugins/dependencies)
  brew install --cask vscodium         # Community-driven, freely-licensed binary distribution of VS Code (no telemetry)
  brew install --formula stylua black isort prettier oxfmt oxlint
}

install_rust() {
  # -----------------------------------------------------------------------------
  # Rust (idempotent check)
  # -----------------------------------------------------------------------------
  if ! command -v rustup &>/dev/null; then
      echo "Installing Rust..."
      # Same safety note as nvm: consider downloading first, then running
      curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  else
      echo "Rust already installed, skipping."
  fi

  # Source cargo env for the current session if available
  if [ -f "$HOME/.cargo/env" ]; then
      . "$HOME/.cargo/env"
  fi
}

install_deno() {
  # -----------------------------------------------------------------------------
  # Deno (idempotent check)
  # -----------------------------------------------------------------------------
  if ! command -v deno &>/dev/null; then
      echo "Installing Deno..."

      curl -fsSL https://deno.land/install.sh | sh
  else
      echo "Deno already installed, skipping."
  fi
}

install_languages_and_runtimes() {
  brew install --formula \
    zig \          # Zig
    go \           # Golang
    mise \         # Universal dev tool version manager (replaces rbenv, nvm, pyenv, …)
    cmake \        # Cross-platform build system generator (used to build C/C++ projects)
    sqlite3 \      # Command-line interface for SQLite, a lightweight disk-based database
    llama.cpp      # Run large language models (LLMs) locally with optimized C++ inference

  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true

  if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
  fi

  mise use --global node@lts
  mise use --global ruby@$(mise latest ruby)
  mise use --global python@$(mise latest python)

  install_rust
  install_deno

  go install golang.org/x/tools/cmd/goimports@latest
  rustup component add rustfmt
}

install_shell_completions() {
  echo "Git completions pinned to v2.47.0. It will need manual updates."

  # -----------------------------------------------------------------------------
  # Git completion
  # -----------------------------------------------------------------------------
  mkdir -p "$HOME/.zsh"

  GIT_COMPLETION_URL="https://raw.githubusercontent.com/git/git/v2.47.0/contrib/completion/git-completion.zsh"
  GIT_COMPLETION_DEST="$HOME/.zsh/git-completion.zsh"

  if [ ! -f "$GIT_COMPLETION_DEST" ]; then
      echo "Downloading git-completion.zsh..."

      curl -fsSL "$GIT_COMPLETION_URL" -o "$GIT_COMPLETION_DEST"
  else
      echo "git-completion.zsh already exists, skipping download."
  fi
}

confirm "Install terminal and shell packages?" && install_terminal_and_shell_packages
confirm "Install editors and their dependencies?" && install_editors_and_their_dependencies
confirm "Install languages and runtimes?" && install_languages_and_runtimes
confirm "Install shell completions?" && install_shell_completions

echo "install.sh complete"
