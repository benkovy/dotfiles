[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

export ZSH=$HOME/.oh-my-zsh
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

if [ $SPIN ]; then
  PS1="YOU ARE ON SPIN $PS1"

  function update-all() {
    cd ~/src/github.com/Shopify
    # Loop over all subdirectories
    for d in ./*; do
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
