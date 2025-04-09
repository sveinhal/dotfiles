# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null)
then
  source `brew --prefix`/etc/grc.zsh

  alias head="grc -es head"
  alias tail="grc -es tail"
  alias ls="grc -es /bin/ls --color"
else
  echo "grc not installed. Install with brew install grc"
fi
