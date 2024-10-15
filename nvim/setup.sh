#!/bin/sh

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

rm -rf ~/.config/nvim/
ln -i -v -s "$SCRIPTDIR/nvchad" ~/.config/nvim

#ln -i -v -s "$SCRIPTDIR/init.vim" ~/.config/nvim/
#ln -i -v -s "$SCRIPTDIR/init.lua" ~/.config/nvim/

nvim +PlugInstall +qall
