DIRECTORY=cinnamon-rhythmbox-tray
if [ -d "$DIRECTORY" ]; then
    rm -rf $DIRECTORY
fi
if [ ! -d "$DIRECTORY" ]; then
    if [ ! -d ~/.local/share/rhythmbox/plugins/"$DIRECTORY" ]; then
	echo "install plugin $DIRECTORY ..."
	git clone https://github.com/paprykut/cinnamon-rhythmbox-tray.git $DIRECTORY
	mkdir -p ~/.local/share/rhythmbox/plugins
	mv $DIRECTORY ~/.local/share/rhythmbox/plugins
    else
	echo "plugin $DIRECTORY already installed"
    fi
fi
