# .bashrc

# Use custom aliases, if file exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_aliases.git ]; then
    . ~/.bash_aliases.git
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

# allow current tty to receive gpg password
export GPG_TTY=$(tty)

# Check if directory exists, and add to path (if it isn't already  in the path)
pathadd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    if [ -n "$2" ]; then
      # Add to front
      PATH="${1}${PATH:+":$PATH"}"
    else
      # Add to end
      PATH="${PATH:+"$PATH:"}$1"
    fi
  fi
}

pathadd $HOME/bin front=true
pathadd $HOME/.rvm/bin
pathadd $HOME/.local/bin
pathadd /usr/local/sbin
pathadd $HOME/node_modules/.bin

# Disable auto renaming terminal
PROMPT_COMMAND=""
export PROMPT_COMMAND

git_branch() {
    # display [@<git-branch>] if in a git repo
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[@\1]/'
}
parse_git_status() {
    # display '*' if files changed, '+' if files uncommitted, '-' if not a git repo
    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working tree clean" ]]; then
        echo -n ""
    elif [[ $(git status 2> /dev/null | tail -n1) == 'nothing added to commit but untracked files present (use "git add" to track)' ]]; then
        echo -n "+"
    elif [[ $(git status 2>&1 | tail -n1) == "fatal: not a git repository (or any of the parent directories): .git" ]]; then
        echo -n "-"
    else
        echo -n "*"
    fi

}

# original
#export PS1="\h:\W \u\$ "
# Display the following, with colors- `<user>@<host> : <dir> [@<branch>]<git-status> \n└─ $`
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u@\h\[\033[0;36m\] : \w\[\033[0;32m\] $(git_branch)$(parse_git_status)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

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
export ANALYTICS=880065222602
