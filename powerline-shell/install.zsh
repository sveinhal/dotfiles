function powerline_precmd() {
    # Suppress Python SyntaxWarnings from powerline-shell's outdated regex patterns
    PS1="$(PYTHONWARNINGS="ignore::SyntaxWarning" powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
