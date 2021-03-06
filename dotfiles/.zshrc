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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
#

# Open tmux by default (attach to main or create main)
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$SPIN" ]; then
  tmux a -t main || exec tmux new -s main && exit;
fi

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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


if [ $SPIN ]; then
  PS1="YOU ARE ON SPIN $PS1"

  function update-all() {
    cd ~/src/github.com/Shopify

    for D in ./*; do
      if [ -d "$D" ]; then
        echo
        echo "updating $D"
        echo
        cd "$D"
        shadowenv trust && git checkout main && git pull
        cd ..
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

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh


[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
