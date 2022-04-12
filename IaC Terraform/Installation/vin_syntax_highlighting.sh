#!/bin/bash

mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo '### Editing ~/.vimrc file...'
sudo echo 'execute pathogen#infect()' >> ~/.vimrc
sudo echo 'syntax on' >> ~/.vimrc
sudo echo 'filetype plugin indent on' >> ~/.vimrc

echo '### Installing the vim-terraform plugin...'
cd ~/.vim/bundle
git clone https://github.com/hashivim/vim-terraform.git
