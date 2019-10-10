# shortcut to this dotfiles path is $ZSH
export DOTFILESDIR=$HOME/.dotfiles
export PATH=$DOTFILESDIR/bin:$PATH

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# source every .zsh and .sh file in this rep (except in bin)
setopt extendedglob
for config_file ($DOTFILESDIR/**/^bin/*.(zsh|sh)) source $config_file
