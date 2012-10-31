#!/bin/bash

sudo apt-get install vim-gtk clang exuberant-ctags byobu irssi irssi-plugin-otr \
	irssi-plugin-xmpp irssi-scripts git

byobu-select-backend screen

git submodule update --init

for file in `ls -A -I .git -I .gitmodules -I setup.sh`;
do
	if [ -e $HOME/$file ] && [ $PWD/$file != `readlink -f $HOME/$file` ]; then
		echo $PWD/$file
		echo "backuping..."
		mv $HOME/$file $HOME/$file-backup-`date +%Y%m%d%H%M%S`
		echo "replacing..."
		ln -sf $PWD/$file $HOME
	fi
done
