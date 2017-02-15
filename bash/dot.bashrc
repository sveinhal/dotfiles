#!/bin/bash

export DOTFILESDIR=$HOME/.dotfiles
export PATH=$DOTFILESDIR/bin:$PATH

SHELLFILES=`find $DOTFILESDIR -name "*.sh" -not -path "$DOTFILESDIR/bin/*" | sort -t\/ -k3n`
for f in $SHELLFILES; do
     source $f
done
