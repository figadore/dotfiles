alias pw='apg -n 19 -x 10 -m 10 -M LCNS -t -s -E 0OI1\|'
alias pws='apg -n 19 -x 10 -m 10 -M lcns -t -s -E 0OI1\|'
alias ll='ls -lh -FG'
alias gcurl='curl -u figadore:$(kr github-pat) '
alias tf='terraform'
alias bat='batcat'

# Use xclip only when native clipboard commands are unavailable.
if command -v xclip >/dev/null 2>&1; then
    if ! command -v pbcopy >/dev/null 2>&1; then
        alias pbcopy='xclip -selection clipboard'
    fi
    if ! command -v pbpaste >/dev/null 2>&1; then
        alias pbpaste='xclip -selection clipboard -o'
    fi
fi

# Prefer Podman when available; docker-real bypasses the alias.
if command -v podman >/dev/null 2>&1; then
    alias docker='podman'
    alias docker-real='command \docker'
fi
