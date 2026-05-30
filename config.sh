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

if [ -d "$HOME/.config/nvim" ]; then
  echo "Removing previous neovim config"

  rm -r "$HOME/.config/nvim"
fi

echo "Copying new neovim config"
cp -R "$CONFIG_DIR/dotfiles/nvim" "$HOME/.config/nvim"

echo "Syncing opencode skills"
mkdir -p "$HOME/.config/opencode/skills"

for skill_dir in "$CONFIG_DIR/dotfiles/opencode/skills"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        dest="$HOME/.config/opencode/skills/$skill_name"
        rm -rf "$dest"
        cp -R "$skill_dir" "$dest"
        echo "  Installed '$skill_name' skill"
    fi
done

echo "config.sh complete"
