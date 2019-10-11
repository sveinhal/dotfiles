PYENV="$(brew --prefix pyenv)/bin/pyenv"
if test -x $PYENV; then 
    eval "$(PYENV init -)"
    eval "$(PYENV virtualenv-init -)"
else
    echo "pyenv not installed. Install with brew install pyenv && brew install pyenv-virtualenv"
fi
unset PYENV
