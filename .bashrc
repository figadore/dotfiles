# .bashrc

HISTSIZE=10000
HISTFILESIZE=20000

# User specific aliases and functions
#don't add commands that start with a space to the bash history
export HISTCONTROL=ignoreboth

#set vim as default editor
export EDITOR=vim


export CLICOLOR=1

PATH=$PATH:$HOME/bin

export PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#disable renaming terminal
PROMPT_COMMAND=""
export PROMPT_COMMAND
