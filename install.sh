#! /bin/bash

if [[ $SPIN ]]; then
  git config --global user.email "ben.kovacs@shopify.com"
  git config --global user.name "Ben Kovacs"
  git config --global --unset-all credential.helper
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  # install oh my zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

ln -sf ~/dotfiles/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/dotfiles/.config/nvim ~/.config/nvim


if command -v rg &> /dev/null
then
    echo "ripgrep is already installed."
else
    echo "ripgrep is not installed. Installing now..."

    # Check if Homebrew is installed
    if command -v brew &> /dev/null
    then
        echo "Homebrew is installed. Proceeding with the installation..."
        brew install ripgrep
    # Check if apt-get is installed
    elif command -v apt-get &> /dev/null
    then
        echo "apt-get is installed. Proceeding with the installation..."
        sudo apt-get update
        sudo apt-get install -y ripgrep
    else
        echo "Neither Homebrew nor apt-get is available on this system. Please install one of them first."
        exit 1
    fi
fi

exit 0
