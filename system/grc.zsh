# GRC colorizes nifty unix tools all over the place

GRC=$(command -v grc)

if [[ -z "$GRC" ]]; then 
  echo "grc not installed."
  return
fi

if [[ -f "/etc/grc.zsh" ]]; then
  source /etc/grc.zsh
elif [[ -f `brew --prefix`/etc/grc.zsh ]]; then
  source `brew --prefix`/etc/grc.zsh
fi

alias head="grc -es head"
alias tail="grc -es tail"
alias ls="grc -es /bin/ls --color"
