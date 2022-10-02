#!/bin/sh

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim
ln -i -v -s "$SCRIPTDIR/init.vim" ~/.config/nvim/

nvim +PlugInstall +qall
