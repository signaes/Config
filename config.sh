#!/bin/bash

set -euo pipefail

echo "config.sh starting"

echo "Symlinking dotfiles"

# Determine the directory where this script lives
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ln -sf "$CONFIG_DIR/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$CONFIG_DIR/dotfiles/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$CONFIG_DIR/dotfiles/zsh/.zsh_functions" "$HOME/.zsh_functions"
ln -sf "$CONFIG_DIR/dotfiles/vim/.vimrc" "$HOME/.vimrc"
ln -sf "$CONFIG_DIR/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$CONFIG_DIR/dotfiles/ghostty/config" "$HOME/.config/ghostty/config"

if [ -d $HOME/.config/nvim ]; then
  echo "Removing previous neovim config"

  rm -r "$HOME/.config/nvim"
fi

echo "Copying new neovim config"
cp -R "$CONFIG_DIR/dotfiles/nvim" "$HOME/.config/nvim"

if [ -d $HOME/.config/opencode/skills ]; then
  echo "Removing previous opencode skills"

  rm -r "$HOME/.config/opencode/skills"
fi

echo "Copying new opencode skills"
mkdir -p "$HOME/.config/opencode"
cp -R "$CONFIG_DIR/dotfiles/opencode/skills" "$HOME/.config/opencode/skills"

echo "config.sh complete"
