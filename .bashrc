# .bashrc

# Use custom aliases, if file exists
if [ -f ~/.bash_aliases ]; then 
    . ~/.bash_aliases
fi

# For rvm
if [ -f ~/.profile ]; then
  source ~/.profile
fi

# Increase scrollback
HISTSIZE=10000
HISTFILESIZE=20000

# User specific aliases and functions
# Don't add commands that start with a space to the bash history
export HISTCONTROL=ignoreboth

# Set vim as default editor
export EDITOR=vim

# Use colors
export CLICOLOR=1

# Check if directory exists, and add to path (if it isn't already  in the path)
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

pathadd $HOME/bin
pathadd $HOME/.rvm/bin
pathadd $HOME/.local/bin
pathadd $HOME/node_modules/.bin

# Disable auto renaming terminal
PROMPT_COMMAND=""
export PROMPT_COMMAND

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# for pylint/flake8 checkers, encoding has to be set here for some reason
export LC_CTYPE=en_US.UTF-8

# Terminal grep colors support
#export GREP_OPTIONS="--color=always"; #deprecated
alias grep='grep --color'
