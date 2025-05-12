# Zoxide is niftier "cd"
if $(command -v zoxide &>/dev/null); then
  eval "$(zoxide init zsh --cmd cd)"
else
  echo "zoxide not installed."
fi
