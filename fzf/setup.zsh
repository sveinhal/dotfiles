# Set up fzf key bindings and fuzzy completion

if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi
