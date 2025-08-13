#!/usr/bin/env bash
# mise - Modern tool version manager (replaces nvm, pyenv, etc.)

if command -v mise &> /dev/null; then
    # Activate mise for current shell
    if [[ -n "$ZSH_VERSION" ]]; then
        eval "$(mise activate zsh)"
    elif [[ -n "$BASH_VERSION" ]]; then
        eval "$(mise activate bash)"
    fi
else
    echo "mise not installed - modern tool version manager"
    echo "Install with: brew install mise"
    echo "Replaces nvm, pyenv, rbenv with one fast tool"
fi