brew update
brew upgrade
brew install fzf tmux tmuxinator the_silver_searcher ripgrep pyenv neovim rbenv 

curl -o ~/.git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

brew install zsh-completion

[[ $(ls ~/.vim | grep backup 2> /dev/null) == "" ]] && echo 'making ~/.vim/backup and ~/.vim/swap dirs' && \
  mkdir ~/.vim/backup ~/.vim/swap 2> /dev/null

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

brew install cmake
brew install wget
brew tap mesca/luarocks
brew install luarocks
brew install lazygit

echo "Installing Deno"
curl -fsSL https://deno.land/install.sh | sh

echo "Installing Zellij"
cargo install --locked zellij
