# shortcut to this dotfiles path is $ZSH
export DOTFILESDIR=$HOME/.dotfiles
export PATH=$DOTFILESDIR/bin:$PATH

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# source every .zsh and .sh file in this repo (except in bin)
# (oe['REPLY=${REPLY:t}']) sorts by filename, so 000-foo.sh loads before 999-bar.zsh
setopt extendedglob
for config_file in $DOTFILESDIR/**/^bin/*.(zsh|sh)(oe['REPLY=${REPLY:t}']); do
   source $config_file
done
