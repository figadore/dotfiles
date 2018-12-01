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
pathadd /usr/local/sbin
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/r631269/google-cloud-sdk/path.bash.inc' ]; then . '/Users/r631269/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/r631269/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/r631269/google-cloud-sdk/completion.bash.inc'; fi

# set up pyenv
eval "$(pyenv init -)"

# Shortcuts for typing
export ART=artifactory.healthsparq.com
export REG=docker-registry.healthsparq.com
export DEV=445930290302
export UAT=304408629837
export PRD=629290951501
export TOOLSPRD=774580802320
export TOOLSDEV=551078432832
export MGMT2=803571735847
