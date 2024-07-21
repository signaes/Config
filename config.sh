ln -sf "$(pwd)/dotfiles/zsh/.zshrc" ~/.zshrc
ln -sf "$(pwd)/dotfiles/vim/.vimrc" ~/.vimrc
ln -sf "$(pwd)/dotfiles/tmux/.tmux.conf" ~/.tmux.conf

rm -r ~/.config/nvim
cp -rs "$(pwd)/dotfiles/nvim" ~/.config/nvim
