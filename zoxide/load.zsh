# Zoxide is niftier "cd"
if $(brew --prefix zoxide &>/dev/null)
then
  eval "$(zoxide init zsh --cmd cd)"
else
  echo "zoxide not installed. Install with brew install zoxide"
fi

