#!/bin/bash

sudo apt-get install vim-gtk clang exuberant-ctags git python-fontforge unzip

# Linking the configuration files
for file in `ls -A -I .git -I .gitmodules -I setup.sh -I .kde`;
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

git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
