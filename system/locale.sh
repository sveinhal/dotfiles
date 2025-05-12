
# Sett fallback-locale hvis ikke allerede satt
if [[ -z "$LANG" || "$LANG" == "C" ]]; then
  export LANG=en_US.UTF-8
fi

# Eventuelt sett LC_ALL også, men unngå å overstyre hvis det er satt
if [[ -z "$LC_ALL" ]]; then
  export LC_ALL=$LANG
fi
