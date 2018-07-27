# refresh.sh - a bash script to refresh my dotfiles repository
# 
# ./refresh.sh copies the relevant configuration files to
# the current folder, so I only have to run this whenever I 
# want to update my dotfiles repo.


# copy xorg config files to folder
cp -r /etc/X11/xorg.conf.d .

# copy rc's over
cp ~/.bashrc .
cp ~/.vimrc .


# copy files from .config
cp -r ~/.config/ranger ./.config/ranger
cp -r ~/.config/neofetch ./.config/neofetch
cp -r ~/.config/i3 ./.config/i3
cp -r ~/.config/i3blocks ./.config/i3blocks
cp -r ~/.config/polybar ./.config/polybar
