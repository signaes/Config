ln -sf "$(pwd)/dotfiles/zsh/.zshrc" ~/.zshrc
ln -sf "$(pwd)/dotfiles/vim/.vimrc" ~/.vimrc
ln -sf "$(pwd)/dotfiles/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "$(pwd)/dotfiles/ghostty/config" ~/.config/ghostty/config

if [ -d ~/.config/nvim ]; then
  rm -r ~/.config/nvim
fi

cp -rs "$(pwd)/dotfiles/nvim" ~/.config/nvim
