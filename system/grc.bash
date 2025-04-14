# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null)
then
  source `brew --prefix`/etc/grc.sh

  alias head="colourify head"
  alias tail="colourify tail"
else
  echo "grc not installed. Install with brew install grc"
fi
