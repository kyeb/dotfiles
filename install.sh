#!/bin/bash
# install.sh - a bash script to install my dotfiles repository
# 
# ./install.sh copies the relevant configuration files to
# the relevant folders across the system, and is meant to eventually
# become a full install script for my setup on my XPS 15.

echo "Copying over config files"
# copy xorg config files to folder
sudo cp -r ./xorg.conf.d /etc/X11

# copy rc's over
cp ./.bashrc ~
cp ./.vimrc ~
cp ./.bash_aliases ~
cp ./.dircolors ~

# reinstall gnome terminal settings
cp -r ./.config/dconf ~/.config

# copy files from .config
cp -r ./.config/ranger ~/.config
cp -r ./.config/neofetch ~/.config
cp -r ./.config/i3 ~/.config
cp -r ./.config/i3blocks ~/.config
cp -r ./.scripts ~ 

echo "Installing basic dependencies"
sudo apt-get install vim git curl apt-transport-https snapd htop

mkdir -p ~/.vim/tmp

echo "Adding repositories for Chrome, VSCode, f.lux"
# activate various repos
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
	>> /etc/apt/sources.list
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
rm linux_signing_key.pub

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# sudo add-apt-repository ppa:nathan-renniewaldock/flux
# sudo apt install fluxgui

# Signal Desktop
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# FISH
sudo apt-add-repository ppa:fish-shell/release-3

# update sources
sudo apt update

echo "Installing basic programs"
# install a bunch of basics
sudo apt-get install google-chrome-stable python3 python3-pip \
	code scrot neofetch xbacklight fish \
    vim-gtk signal-desktop trash-cli compton \
    texlive-latex-extra xdotool
sudo apt-get upgrade
sudo snap install slack --classic

echo "Installing ranger dev icons"
git clone git@github.com:alexanderjeurissen/ranger_devicons.git ranger_devicons
cd ranger_devicons && sudo make install && cd .. && rm -rf ranger_devicons

echo "Installing Ranger"
pip install ranger
sudo apt install w3m-img

mkdir -p ~/.fonts
cd ~/.fonts && curl -fLo "Source Code Pro Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf

fc-cache -vf

# fix the chrome sources list thing
sudo rm /etc/apt/sources.list.d/google-chrome.list

echo "Installing i3-gaps"
# install i3-gaps based on the script at 
# https://github.com/maestrogerardo/i3-gaps-deb
cd ~/Downloads
git clone https://github.com/maestrogerardo/i3-gaps-deb.git
cd i3-gaps-deb
./i3-gaps-deb

echo "Installing Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Installing vim-airline"
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline

echo "Installing oh-my-fish"
curl -L https://get.oh-my.fish | fish


echo "NOT INSTALLED: LATEX (http://tug.org/texlive/quickinstall.html)


