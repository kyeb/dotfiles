#!/bin/bash
# refresh.sh - a bash script to refresh my dotfiles repository
# 
# ./refresh.sh copies the relevant configuration files to
# the current folder, so I only have to run this whenever I 
# want to update my dotfiles repo.


# dconf (gnome terminal configuration, etc.)
cp -r ~/.config/dconf ./config/dconf

# copy home directory config files over
cp ~/.vimrc ./vimrc
cp ~/.gitconfig ./gitconfig

# copy files from .config
cp ~/.config/ranger/* ./config/ranger > /dev/null 2>&1
cp ~/.config/stretchly/config.json ./config/stretchly/config.json
cp ~/.config/compton.conf ./config/compton.conf
cp -r ~/.config/neofetch ./config
cp -r ~/.config/i3 ./config
cp -r ~/.config/i3blocks ./config
cp ~/.config/Code/User/settings.json ./config/code/settings.json
cp ~/.config/fish/config.fish ./config/fish/config.fish
cp -r ~/.config/fish/functions ./config/fish

cp -r ~/scripts ./scripts

apt list --installed | grep "\[installed\]" > installed_programs

