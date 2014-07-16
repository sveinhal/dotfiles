#!/bin/bash

export DOTFILESDIR=$HOME/.dotfiles
export PATH=$DOTFILESDIR/bin:$PATH

SHELLFILES=`find $DOTFILESDIR -name "*.sh" | sort -t\/ -k3n`
for f in $SHELLFILES; do
     source $f
done

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
