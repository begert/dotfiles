#!/bin/bash
mv -v ~/.vimrc ~/.vimrc_old 2> /dev/null
ln -s ~/dotfiles/vimrc ~/.vimrc

mv -v ~/.vim ~/.vim_old 2> /dev/null
ln -s ~/dotfiles/vim ~/.vim
