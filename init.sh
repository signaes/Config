echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/thiagooliveira/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

if [ ! -d $HOME/.config/ghostty ]; then
  mkdir $HOME/.config/ghostty
fi

mkdir $HOME/bin
