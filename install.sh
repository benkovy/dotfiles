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

exit 0
