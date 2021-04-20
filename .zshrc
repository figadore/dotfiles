# don't share history between tmux sessions
setopt nosharehistory


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

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
#zsh version
setopt HIST_IGNORE_SPACE

# Set vim as default editor
export EDITOR=vim

# Set vi style bindings in shell
bindkey -v
bindkey '^R' history-incremental-search-backward
# ctrl j and k to go up and down in history
bindkey -M viins '^J' history-incremental-search-forward
bindkey -M viins '^K' history-incremental-search-backward

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

if [ -f ~/.git-completion.zsh ]; then
  . ~/.git-completion.zsh
fi

# for pylint/flake8 checkers, encoding has to be set here for some reason
export LC_CTYPE=en_US.UTF-8

# Terminal grep colors support
#export GREP_OPTIONS="--color=always"; #deprecated
alias grep='grep --color'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/r631269/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/r631269/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/r631269/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/r631269/google-cloud-sdk/completion.zsh.inc'; fi

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


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Enable autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
# Disable less as a git pager
export PAGER=

# don't share history between tmux sessions
setopt nosharehistory
setopt noincappendhistory

# don't share history between zsh sessions
unsetopt share_history
setopt no_share_history

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
