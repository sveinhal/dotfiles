#!/usr/bin/env bash
# Oh My Posh - modern, powerline-like prompt

if command -v oh-my-posh &> /dev/null; then
    # Use powerline-like theme for consistency across machines
    eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/custom-powerline.json)"
else
    echo "oh-my-posh not installed - modern prompt"
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "Install with: brew install oh-my-posh"
    else
        echo "Install locally: curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin"
    fi
fi