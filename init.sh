#!/bin/bash

set -euo pipefail

source ./functions.sh

echo "init.sh starting"

install_and_setup_homebrew() {
  echo "Installing Homebrew"

  # This downloads and runs remote code. See: https://brew.sh/
  if ! command -v brew &>/dev/null; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Add Homebrew to shell env if not already present (idempotent)
  HOMEBREW_EVAL='eval "$(/opt/homebrew/bin/brew shellenv)"'
  ZPROFILE="$HOME/.zprofile"

  if [ -f "$ZPROFILE" ] && ! grep -qF "$HOMEBREW_EVAL" "$ZPROFILE"; then
      echo "" >> "$ZPROFILE"
      echo "$HOMEBREW_EVAL" >> "$ZPROFILE"
  elif [ ! -f "$ZPROFILE" ]; then
      echo "$HOMEBREW_EVAL" > "$ZPROFILE"
  fi

  eval "$HOMEBREW_EVAL"
}

make_directories() {
  mkdir -p "$HOME/.config/ghostty"
  mkdir -p "$HOME/bin"
  mkdir -p "$HOME/.vim/backup"
  mkdir -p "$HOME/.vim/swap"
}

confirm "Install and setup homebrew?" && install_and_setup_homebrew
confirm "Make directories? (Needed for the next steps)" && make_directories

echo "init.sh complete"
