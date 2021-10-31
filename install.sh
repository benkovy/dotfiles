#! /bin/bash

echo "Working in"
echo "- $(pwd)"

# Link dotfiles
#
echo
echo Linking dotfiles
echo ----------------
echo

HOMEDIR=$HOME
BACKUPDIR="$HOMEDIR/.dotfiles.backups"
CURRENTDIR=$(pwd -P)
DOTFILEDIR="$CURRENTDIR/dotfiles"

backup_dotfile() {
  if [[ -e "$HOMEDIR/$1" ]]; then

    # Do we already have any backups? How many?
    # This needs some work. Doesn't handle things like
    # $BACKUPDIR/.vim* and $BACKUPDIR/.vimrc* well
    dotfile_count=$(find $BACKUPDIR/$1* -maxdepth 0 2> /dev/null | wc -l | sed 's/ //g')

    if [[ $dotfile_count -ne '0' ]]; then
      mv $HOMEDIR/$1 $BACKUPDIR/$1.$dotfile_count
    else
      mv $HOMEDIR/$1 $BACKUPDIR/$1
    fi
  fi
}

symlink_dotfile() {
  ln -s $DOTFILEDIR/$1 $HOMEDIR/$1
}


if [[ ! -e $BACKUPDIR ]]; then
  echo "Creating back ups folder $BACKUPDIR..."
  mkdir $BACKUPDIR
fi

dotfiles=$(ls -1 -A $DOTFILEDIR 2> /dev/null)

if [[ $dotfiles ]]; then
  echo "Symlinking dotfiles..."

  for dotfile in $dotfiles; do
    echo "$dotfile"
    backup_dotfile $dotfile
    symlink_dotfile $dotfile
  done

  echo "All set! Any existing files were moved to $BACKUPDIR"

else
  echo "You don't have anything in '$DOTFILEDIR'"
fi



# Install dependencies
#
echo
echo Installing dependencies
echo -----------------------
echo

function install {
  if ! command -v name &> /dev/null; then
    if command -v apt-get &> /dev/null; then
      sudo apt-get install -y $1
    elif command -v brew &> /dev/null; then
      brew install $1
    fi
  fi
  echo "--- $1 installed"
}

# Neovim
if command -v apt-get &> /dev/null; then
  sudo add-apt-repository ppa:neovim-ppa/unstable
  sudo apt-get update
fi
install neovim

curl -fLso ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall
echo --- neovim configured
echo

install tmux

echo Installing zsh plugins
echo ---------------------- \n

# auto complete for zsh
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


if [[ $SPIN ]]; then
  git config --global user.email "ben.kovacs@shopify.com"
  git config --global user.name "Ben Kovacs"
  git config --global --unset-all credential.helper
fi
