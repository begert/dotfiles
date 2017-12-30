#!/bin/bash

function safe_link() {
    if [ -e $2 ]; then
        echo ":( $2 already exists, will not overwrite"
    else
        echo ":) linked $2"
        ln -s $1 $2
    fi
}

# install normal vimrc file
safe_link ~/dotfiles/vimrc ~/.vimrc

safe_link ~/dotfiles/ideavimrc ~/.ideavimrc
safe_link ~/dotfiles/tmux.conf ~/.tmux.conf

# install vimrc as nvim init script
mkdir -p ~/.config/nvim
safe_link ~/dotfiles/vimrc ~/.config/nvim/init.vim

# install vim plugins
if [ -e ~/.vim ]; then
    echo ":( ~/.vim already exists, will not overwrite"
else
    mkdir ~/.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
fi

