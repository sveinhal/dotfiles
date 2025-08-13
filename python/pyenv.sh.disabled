if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -z "$HOMEBREW_PREFIX" ]]; then
        return 0 2>/dev/null || exit 0
    fi

    PYENV="$(brew --prefix pyenv)/bin/pyenv"
    if [[ -x $PYENV ]]; then 
        eval "$(PYENV init --path)"
        eval "$(PYENV init -)"
        eval "$(PYENV virtualenv-init -)"
    else
        echo "pyenv not installed. Install with brew install pyenv && brew install pyenv-virtualenv"
    fi
    unset PYENV
elif [[ -x $HOME/.pyenv/bin/python ]]; then
    export PATH=$PATH:$HOME/.pyenv/bin/
else
    echo "No virtual python environment. On OSX, use brew install pyenv, on Linux create a virtual environment using python3 -m venv ~/.pyenv"
fi

