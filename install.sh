#!/bin/bash

set -euo pipefail

source ./functions.sh

echo "install.sh starting"

eval "$(/opt/homebrew/bin/brew shellenv)"

# -----------------------------------------------------------------------------
# Homebrew setup
# -----------------------------------------------------------------------------
if ! command -v brew &>/dev/null; then
    echo "ERROR: Homebrew is not installed. Run make init first."
    exit 1
fi

confirm "Update homebrew? - Updates Homebrew itself and fetches the latest package metadata (formulae and casks) from the repositories. It does not upgrade any installed packages." && brew update

install_terminal_and_shell_packages() {
  brew install --cask ghostty
  brew install --formula jq jsonlint uv ruff fzf tmux ffmpeg tmuxinator the_silver_searcher ripgrep                            
  brew install --formula zsh-autosuggestions zsh-syntax-highlighting zsh-completions
  brew install --formula fd bat pastel wget lazygit imagemagick opencode ghostscript harper hadolint vale poppler                            

  brew install colima docker docker-compose
  brew install --cask ollama-app
}

install_editors_and_their_dependencies() {
  brew install --formula neovim
  brew tap mesca/luarocks
  brew install luarocks
  brew install --cask vscodium
  brew install --formula stylua prettier oxfmt oxlint
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

install_languages_linting_tools_and_runtimes() {
  brew install --formula zig go mise cmake sqlite3

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

  brew install shellcheck luacheck golangci-lint markdownlint-cli2 stylelint

  npm i -g typescript
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
confirm "Install languages, linting tools and runtimes?" && install_languages_linting_tools_and_runtimes
confirm "Install shell completions?" && install_shell_completions

echo "install.sh complete"
