#!/usr/bin/env bash

git pull
git submodule init
git submodule update --recursive

function doIt() {
	rsync --exclude ".gitmodules" --exclude ".gitconfig" --exclude ".git/" --exclude "install.sh" --exclude "README.md" -av . ~
}

function doPowerLine(){
	cp ./.powerline-shell/config.py.dist ./.powerline-shell/config.py
	./.powerline-shell/install.py
}

function doRhythmbox(){
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
}

function doMutt(){
    DIRECTORY=~/.mutt
    if [ -d "$DIRECTORY" ]; then
	rm -rf $DIRECTORY
    fi
    if [ ! -d "$DIRECTORY" ]; then
	wget -q -O - ftp://ftp.mutt.org/mutt/devel/mutt-1.5.23.tar.gz | tar xvfz -
	cd ./mutt-1.5.23
	wget -q -O - http://lunar-linux.org/~tchan/mutt/patch-1.5.23.sidebar.20140412.txt | patch -p1
	./configure --enable-imap --enable-smtp --enable-pop --enable-mailtool  --with-ssl --enable-hcache  --with-sasl=/usr/local
	make
	sudo make install
	mkdir ~/.mutt
	mkdir ~/.mutt/themes/
	git clone https://github.com/altercation/mutt-colors-solarized.git
	cp .muttrc ~/.muttrc
    fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
    doRhythmbox
    doMutt
    doPowerLine
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
    read -p "Install Rhytmbox plugin? (y/n)" -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doRhythmbox
    fi
    read -p "Install Mutt configs? (y/n)" -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doMutt
    fi
    read -p "Install Powerline? (y/n)" -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doPowerLine
    fi
fi
