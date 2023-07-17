# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  web-search
  copypath
  copyfile
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias vi="nvim"
alias vim="nvim"
alias vimn="nvim"

# spin aliases
alias ss="spin shell"
alias sos="spin open shopify"
alias su="spin use"
alias sl="spin list"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ $SPIN ]; then
  PS1="YOU ARE ON SPIN $PS1"

  function update-all() {
    cd ~/src/github.com/Shopify
    # Loop over all subdirectories
    for d in $dir/*; do
      if [ -d "$d" ]; then
        cd "$d"
        # Check if the repository has a 'main' branch
        if git show-ref --verify --quiet refs/heads/main; then
          shadowenv trust && git checkout main && git pull
        # If not, check if the repository has a 'master' branch
        elif git show-ref --verify --quiet refs/heads/master; then
          shadowenv trust && git checkout master && git pull
        else
          echo "Neither main nor master branch found in repository: $d"
        fi
      fi
    done
  }

  function logs() {
    journalctl -f --unit $1
  }

  function list() {
    if [ $1 ]; then
      if [ $1 = "-f" ]; then
        systemctl list-units --failed
      else
        iso procs list shopify--$1
      fi
    else
      iso procs list
    fi
  }
fi
