if [[ -z "$HOMEBREW_PREFIX" ]]; then
    return 0 2>/dev/null || exit 0
fi
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
