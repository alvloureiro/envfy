#!/bin/bash

sudo apt-get install vim-gtk clang exuberant-ctags byobu irssi irssi-plugin-otr \
	irssi-plugin-xmpp irssi-scripts git python-fontforge

byobu-select-backend screen

git submodule update --init
git submodule foreach git checkout master

for file in `ls -A -I .git -I .gitmodules -I setup.sh`;
do
	echo $PWD/$file

	if [ $PWD/$file == `readlink -f $HOME/$file` ]; then
		echo "skipping..."
		continue
	elif [ -e $HOME/$file ]; then
		echo "backuping..."
		mv $HOME/$file $HOME/$file-backup-`date +%Y%m%d%H%M%S`
		echo "replacing..."
	else
		echo "linking..."
	fi

	ln -sf $PWD/$file $HOME
done

if [ ! -e $HOME/.fonts ]; then

	mkdir ~/tmp
	wget -c http://font.ubuntu.com/download/ubuntu-font-family-0.80.zip -O ~/tmp/ubuntu-font-family-0.80.zip
	cd ~/tmp
	unzip ubuntu-font-family-0.80.zip

	cd ubuntu-font-family-0.80

	chmod +x ~/.vim/bundle/general/vim-powerline.git/fontpatcher/fontpatcher

	for f in `ls *.ttf`;
	do
		~/.vim/bundle/general/vim-powerline.git/fontpatcher/fontpatcher $f
	done

	mkdir $HOME/.fonts

	fonts=`ls *Powerline.ttf`
	cp $fonts $HOME/.fonts

	rm -rf ~/tmp
fi

sudo fc-cache -vf
