DIRECTORY=~/.mutt
if [ -d "$DIRECTORY" ]; then
    rm -rf $DIRECTORY
fi
if [ ! -d "$DIRECTORY" ]; then
    mkdir ~/.mutt
    mkdir ~/.mutt/themes/
    git clone https://github.com/altercation/mutt-colors-solarized.git
    cp .muttrc ~/.muttrc
fi
