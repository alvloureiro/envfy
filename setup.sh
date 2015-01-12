#!/bin/bash

echo -e "Installing envfy on your home folder...\n"
echo -e "Updating the package manager...\n"

sudo apt-get update
echo -e "Installing necessary packages..."
sudo apt-get install build-essential cmake vim vim-common vim-gtk\
                     clang exuberant-ctags git python-fontforge python-dev unzip


echo -e "Creating symbolic links for default configuration files..."
# Linking the configuration files
for file in `ls -A -I .git -I setup.sh`;
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
