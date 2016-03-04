#brew stuff
export RBENV_ROOT=/usr/local/var/rbenv

#modified by me with 2> to avoid error display when not found
if which rbenv 2> /dev/null > /dev/null; then eval "$(rbenv init -)";  fi

# source rvm script file if it exists
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

