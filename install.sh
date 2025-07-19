brew update
brew upgrade
brew install --cask ghostty
brew install fzf tmux tmuxinator the_silver_searcher ripgrep pyenv neovim rbenv dua-cli bottom macmon csvlens cmake wget lazygit zsh-autosuggestions zsh-syntax-highlighting llama.cpp sqlite3
brew tap mesca/luarocks
brew install luarocks

curl -o ~/.git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

brew install zsh-completion

if [ ! -d ~/.vim/backup ]; then
  mkdir ~/.vim/backup
fi

if [ ! -d ~/.vim/swap ]; then
  mkdir ~/.vim/swap
fi

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"

echo "Installing Deno"
curl -fsSL https://deno.land/install.sh | sh

echo "Installing Bun"
curl -fsSL https://bun.sh/install | bash
