#!/usr/bin/env bash
# Unified Python management - tries uv first, falls back to pyenv

# Try UV first (preferred, modern solution)
if command -v uv &> /dev/null; then
    # UV is available - use it as primary Python manager
    export PATH="$HOME/.local/bin:$PATH"
    
    # Enable shell completion
    if [[ -n "$ZSH_VERSION" ]]; then
        eval "$(uv generate-shell-completion zsh)"
    elif [[ -n "$BASH_VERSION" ]]; then
        eval "$(uv generate-shell-completion bash)"
    fi
    
    # Convenience aliases
    alias python-list='uv python list --only-installed'
    alias python-install='uv python install'
    alias py='uv run python'
    alias venv='uv venv'
    alias venv-activate='source .venv/bin/activate'
    
    # Mark that we're using UV
    export PYTHON_MANAGER="uv"
    
# Fall back to pyenv (for systems where uv isn't available)
elif [[ "$(uname)" == "Darwin" ]]; then
    # macOS with Homebrew pyenv
    if [[ -n "$HOMEBREW_PREFIX" ]]; then
        PYENV="$(brew --prefix pyenv 2>/dev/null)/bin/pyenv"
        if [[ -x $PYENV ]]; then 
            eval "$($PYENV init --path)"
            eval "$($PYENV init -)"
            eval "$($PYENV virtualenv-init -)" 2>/dev/null
            export PYTHON_MANAGER="pyenv"
        else
            echo "Neither uv nor pyenv installed."
            echo "Install with: brew install uv (recommended) or brew install pyenv"
        fi
        unset PYENV
    fi
    
elif [[ -x $HOME/.pyenv/bin/pyenv ]]; then
    # Linux/Debian with manually installed pyenv
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)" 2>/dev/null
    export PYTHON_MANAGER="pyenv"
    
elif [[ -x $HOME/.pyenv/bin/python ]]; then
    # Fallback: just add pyenv bin to PATH
    export PATH="$PATH:$HOME/.pyenv/bin/"
    export PYTHON_MANAGER="pyenv-simple"
    
else
    # No Python manager found
    echo "No Python version manager found."
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "Install with: brew install uv (recommended)"
    elif [[ -f /etc/debian_version ]]; then
        echo "Ask admin to install uv, or create a virtual environment locally:"
        echo "  python3 -m venv ~/.pyenv"
    else
        echo "Install uv og pyenv"
    fi
fi

# Debug info (comment out in production)
# echo "Python manager: ${PYTHON_MANAGER:-none}"