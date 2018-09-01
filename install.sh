# install.sh - a bash script to install my dotfiles repository
# 
# ./install.sh copies the relevant configuration files to
# the relevant folders across the system, and is meant to 

# copy xorg config files to folder
sudo cp -r ./xorg.conf.d /etc/X11

# copy rc's over
cp ./.bashrc ~
cp ./.vimrc ~
cp ./.bash_aliases ~
cp ./.dircolors ~

# reinstall gnome terminal settings
cp ./.config/dconf ~/.config

# copy files from .config
cp -r ./.config/ranger ~/.config
cp -r ./.config/neofetch ~/.config
cp -r ./.config/i3 ~/.config
cp -r ./.config/i3blocks ~/.config
cp -r ./.scripts ~ eventually do a full install of my preferred system setup
sudo apt install vim git curl apt-transport-https snapd htop

mkdir ~/.vim/tmp

# install chrome repo
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
	>> /etc/apt/sources.list
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
rm linux_signing_key.pub

# activate various repos
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo add-apt-repository ppa:nathan-renniewaldock/flux

# update sources
sudo apt update

# install a bunch of basics
sudo apt install google-chrome-stable python3 python3-pip ranger \
	code fonts-powerline scrot neofetch fluxgui
sudo snap install slack --classic

# install powerline
pip install powerline-shell
# fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
fc-cache -vf

# fix the chrome sources list thing
sudo rm /etc/apt/sources.list.d/google-chrome.list

# install i3-gaps based on the script at 
# https://github.com/maestrogerardo/i3-gaps-deb
cd ~/Downloads
git clone https://github.com/maestrogerardo/i3-gaps-deb.git
cd i3-gaps-deb
./i3-gaps-deb

