#!/bin/bash

mv -v ~/.vimrc ~/.vimrc_old 2> /dev/null
ln -s ~/dotfiles/vimrc ~/.vimrc

mv -v ~/.vim ~/.vim_old 2> /dev/null
ln -s ~/dotfiles/vim ~/.vim

mv -v ~/.nvimrc ~/.nvimrc_old 2> /dev/null
ln -s ~/dotfiles/vimrc ~/.nvimrc

mv -v ~/.ideavimrc ~/.ideavimrc_old 2> /dev/null
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc

mv -v ~/.tmux.conf ~/.tmux.conf_old 2> /dev/null
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
vim +PluginInstall +qall
