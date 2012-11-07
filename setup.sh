#!/bin/bash

sudo apt-get install vim-gtk clang exuberant-ctags byobu irssi irssi-plugin-otr \
	irssi-plugin-xmpp irssi-scripts git

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
