# Set up fzf key bindings and fuzzy completion

if command -v fzf &> /dev/null; then
    source <(fzf --zsh 2>/dev/null) 2>/dev/null
fi
