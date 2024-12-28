echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/thiagooliveira/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

mkdir "$HOME/.config/ghostty"
