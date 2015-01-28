#!/bin/bash

current_dir=`pwd`

echo -e "Installing envfy on your home folder...\n"
echo -e "Updating the package manager...\n"

sudo apt-get update > /dev/null
echo -e "Installing necessary packages..."
sudo apt-get install build-essential cmake vim vim-common vim-gtk\
                     clang exuberant-ctags git python-fontforge python-dev unzip \
                     > /dev/null


echo -e "Creating symbolic links for default configuration files..."
# Linking the configuration files
for file in `ls -A -I .git -I setup.sh -I README.md -I .config`;
do

    if [ \( $PWD/$file == ".gitconfig" \) -a \( -f $HOME/.gitconfig \) ]; then
        echo "git already configured..."
        continue
    elif [ $PWD/$file == `readlink -f $HOME/$file` ]; then
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

echo -e "Installing powerline fonts...\n"
powerline_fonts=$HOME/powerline-fonts
mkdir -p $powerline_fonts
git clone https://github.com/powerline/fonts.git $powerline_fonts
cd $powerline_fonts
./install.sh

powerline_symbols_dir=$HOME/.config/fontconfig/conf.d
local_powerline_symbols_dir=$current_dir/.config/fontconfig/conf.d
powerline_conf_path=$local_powerline_symbols_dir/10-powerline-symbols.conf

if ! [ -d $powerline_symbols_dir ]; then
    mkdir -p $powerline_symbols_dir
fi

cp $powerline_conf_path $powerline_symbols_dir
