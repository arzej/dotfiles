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
