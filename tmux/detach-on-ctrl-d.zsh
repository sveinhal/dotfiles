#!/bin/zsh

_detach_precmd() {
  if [[ -n "$TMUX" && "$SHLVL" == "2" && -o interactive ]]; then
    export SHOULD_DETACH_TMUX=1
    setopt ignore_eof
  else
    unset SHOULD_DETACH_TMUX
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _detach_precmd
_detach_precmd  # Kjør én gang direkte

# Vår egen funksjon for å fange Ctrl+D
zle-detach-or-exit() {
  if [[ "$SHOULD_DETACH_TMUX" == "1" ]]; then
    tmux detach
    zle reset-prompt  # Ikke avslutt skallet
  else
    # Lar Zsh gå videre til å vurdere exit som vanlig
    zle .delete-char-or-list
  fi
}

# Koble funksjonen til EOF (Ctrl+D)
zle -N zle-detach-or-exit
bindkey -r '^D'
bindkey '^D' zle-detach-or-exit
