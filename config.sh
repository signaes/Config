#!/bin/bash

set -euo pipefail

echo "config.sh starting"

echo "Symlinking dotfiles"

# Determine the directory where this script lives
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf "$CONFIG_DIR/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$CONFIG_DIR/dotfiles/zsh/.zsh_functions" "$HOME/.zsh_functions"
ln -sf "$CONFIG_DIR/dotfiles/vim/.vimrc" "$HOME/.vimrc"
ln -sf "$CONFIG_DIR/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$CONFIG_DIR/dotfiles/ghostty/config" "$HOME/.config/ghostty/config"

if [ -d ~/.config/nvim ]; then
  echo "Removing previous neovim config"

  rm -r "$HOME/.config/nvim"
fi

echo "Copying new neovim config"
cp -R "$CONFIG_DIR/dotfiles/nvim" "$HOME/.config/nvim"

echo "config.sh complete"
