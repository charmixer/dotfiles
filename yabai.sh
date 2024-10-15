#!/bin/sh

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

rm -rf ~/.config/yabai
mkdir ~/.config/yabai
ln -i -v -s "$SCRIPTDIR/config/yabai/yabairc" ~/.config/yabai/yabairc


rm -rf ~/.config/skhd
mkdir ~/.config/skhd
ln -i -v -s "$SCRIPTDIR/config/skhd/skhdrc" ~/.config/skhd/skhdrc
