#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTDIR=`dirname $SCRIPT`

curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o ~/Library/Fonts/MesloLGSRegularPowerline.ttf

osascript -e 'tell application "Terminal"
    set ProfilesNames to name of every settings set
    repeat with ProfileName in ProfilesNames
        set font name of settings set ProfileName to "MesloLGS-NF-Regular"
        set font size of settings set ProfileName to 11
    end repeat
end tell
'

#ln -i -v -s "$SCRIPTDIR/zshrc" ~/.zshrc
#ln -i -v -s "$SCRIPTDIR/p10k.zsh" ~/.p10k.zsh
ln -i -v -s "$SCRIPTDIR/starship.toml" ~/.config/starship.toml
ln -i -v -s "$SCRIPTDIR/m1.env" ~/.env

FISH=`which fish`
if [ "$SHELL" != "$FISH" ]; then
  grep -q "^$FISH" /etc/shells || echo "$FISH" | sudo tee -a /etc/shells
  chsh -s "$FISH"
fi
