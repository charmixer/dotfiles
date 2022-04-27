#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

echo "Remember to install powerline fonts: https://stackoverflow.com/questions/63148517/how-to-install-powerline-fonts-on-wsl"

# instasll oh-my-zsh
OMZ_DIR=~/.oh-my-zsh
if [ ! -d $OMZ_DIR ]; then
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# install theme
if [ ! -d $OMZ_DIR/custom/themes/powerlevel10k ]; then
  git clone https://github.com/romkatv/powerlevel10k.git $OMZ_DIR/custom/themes/powerlevel10k
else
  git -C $OMZ_DIR/custom/themes/powerlevel10k pull
fi

ln -i -v -s "$SCRIPTDIR/zshrc" ~/.zshrc
ln -i -v -s "$SCRIPTDIR/p10k.zsh" ~/.p10k.zsh
ln -i -v -s "$SCRIPTDIR/wsl.env" ~/.env

chsh -s $(which zsh)
