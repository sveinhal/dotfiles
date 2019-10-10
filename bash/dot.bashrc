#!/bin/bash

export DOTFILESDIR=$HOME/.dotfiles
export PATH=$DOTFILESDIR/bin:$PATH

SHELLFILES=`find $DOTFILESDIR -name "*.sh" -or -name "*.bash" \
   | grep -v "$DOTFILESDIR/bin/" \
   | awk -F'/' '{print $NF"|"$0}' \
   | sort -t"|" -k1n \
   | cut -f2- -d'|' \
`

for f in $SHELLFILES; do
     source $f
done
