#!/bin/sh
# install cefore and cefpyco

sudo apt-get install -y autoconf automake

git clone https://github.com/cefore/cefore.git
cd cefore/ || exit; autoconf; cd - || exit
cd cefore/ || exit; automake; cd - || exit
cd cefore/ || exit; ./configure --enable-csmgr --enable-cache; cd - || exit
cd cefore/ || exit; make; cd - || exit
cd cefore/ || exit; sudo make install; cd - || exit
cd cefore/ || exit; sudo ldconfig; cd - || exit

git clone https://github.com/cefore/cefpyco
cd cefpyco/ || exit; cmake .; cd - || exit;
cd cefpyco/ || exit; sudo make install; cd - || exit
