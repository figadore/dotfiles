
# Source global definitions
if [ -f /etc/bashrc ]; then 
    . /etc/bashrc
fi
if [ -f ~/.bash_aliases ]; then 
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc ]; then 
    source ~/.bashrc
fi

PATH=$PATH:$HOME/bin

export PATH

#terminal colors plugin support
#export GREP_OPTIONS="--color=always";
export CLICOLOR=1;

#disable renaming terminal
PROMPT_COMMAND=""
export PROMPT_COMMAND

#brew stuff
export RBENV_ROOT=/usr/local/var/rbenv

#modified by me with 2> to avoid error display when not found
if which rbenv 2> /dev/null > /dev/null; then eval "$(rbenv init -)";  fi

#for rvm
source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
