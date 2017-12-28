
# Source global definitions
if [ -f /etc/bashrc ]; then 
    . /etc/bashrc
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/r631269/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/r631269/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/r631269/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/r631269/Downloads/google-cloud-sdk/completion.bash.inc'; fi
