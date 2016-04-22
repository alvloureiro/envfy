#!/bin/bash

if [ $# -eq 0 ]
then
    echo -e "Please use setup.sh with --install or --uninstall\n"
    exit 1
elif [ $1 == "--install" ]
then
    CURRENT_DIR=`pwd`
    POWERLINEFONTS_DIR=$HOME/powerline-fonts
    POWERLINESYMBOLS_DIR=$HOME/.config/fontconfig/conf.d
    LOCALPOWERLINESYMBOLS_DIR=$CURRENT_DIR/.config/fontconfig/conf.d
    POWERLINECONF_PATH=$LOCALPOWERLINESYMBOLS_DIR/10-powerline-symbols.conf

    echo -e "Installing envfy on your home folder...\n"
    echo -e "Updating the package manager...\n"

    sudo apt-get update > /dev/null
    if [ $? -eq 1 ]
    then
        echo -e "Could not update the package manager...\n"
        exit 1
    fi

    echo -e "Installing necessary packages..."
    sudo apt-get install build-essential cmake vim vim-common vim-gtk\
        clang exuberant-ctags git python-fontforge python-dev unzip \
        > /dev/null
    if [ $? -eq 1 ]
    then
        echo "Failed when try install packages...\n"
        exit 1
    fi

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

    # getting the vundle vim plugin
    echo -e "Cloning vundle vim's plugin...\n"
    git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    if [ $? -eq 1 ]
    then
        echo -e "Could not clone vundle vim's plugin...\n"
        exit 1
    fi

    vim +PluginInstall +qall

    echo -e "Installing powerline fonts...\n"
    mkdir -p $POWERLINEFONTS_DIR
    git clone https://github.com/powerline/fonts.git $POWERLINEFONTS_DIR
    cd $POWERLINEFONTS_DIR
    ./install.sh

    if ! [ -d $POWERLINESYMBOLS_DIR ]; then
        mkdir -p $POWERLINESYMBOLS_DIR
    fi

    cp $POWERLINECONF_PATH $POWERLINESYMBOLS_DIR
elif [ $1 == "--uninstall" ]
then
    echo -e "Uninstalling envfy from your environment...\n"

    for file in `ls -A -I .git -I setup.sh -I README.md -I .config`;
    do

        if [ \( $PWD/$file == ".gitconfig" \) -a \( -f $HOME/.gitconfig \) ]; then
            echo -e "removing .gitconfig file from your environment...\n"
            rm $HOME/.gitconfig
        elif [ $PWD/$file == `readlink -f $HOME/$file` ]; then
            echo -e "removing $file from your environment...\n"
            rm $HOME/$file
        fi
    done

    read -p "Would you like to remove all pre-installed packages?[y/n]" answer
    if [ $answer == 'y' ]
    then
        sudo apt-get remove --purge build-essential cmake vim vim-common vim-gtk\
        clang exuberant-ctags git python-fontforge python-dev unzip > /dev/null
        echo -e "All packages were removed...\n"
    fi
else
    echo -e "Invalid option $1\n"
    echo -e "Please use \"setup.sh\" with --install or --uninstall\n"
    exit 1
fi

exit 0
