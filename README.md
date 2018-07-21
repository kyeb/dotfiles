# kyeb dotfiles

This repo contains various configuration files for my Linux setup on my Dell XPS 15 (9550). There isn't anything crazy cool here, but it's a decent aggregation of how-to's for newbies to i3wm and ricing. Regardless, anyone is free to use the files/info contained here. 

## Bash configuration 

Location: ~/.bashrc

- Powerline-shell ([source](https://github.com/b-ryan/powerline-shell))
- Aliases - see .bashrc in this repo for various aliases I like to use

## Vim configuration

Location: ~/.vimrc

- Stop saving those annoying ..filename.ext.un~ and filename.ext~ files to current directory ([source](https://stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension))
      
      ```
      set backupdir=~/vimtmp,.
      set directory=~/vimtmp,.
      set undodir=~/vimtmp,.
      ```


## i3 config changes

Location: ~/.i3/config

- Switch to dmenu-desktop (uncomment/comment the relevant lines)
- Map caps lock to esc ([source](https://askubuntu.com/questions/363346/how-to-permanently-switch-caps-lock-and-esc))

```
      exec xmodmap -e "clear lock"  # clears the caps lock function
      exec xmodmap -e "keycode 66 = Escape NoSymbol Escape" # sets it to escape
```

- A somewhat normal suspend action in i3

```
      bindsym Mod1+x exec i3lock -e && systemctl suspend
```


## Other

- Touchpad tweaks (general temporary instructions)

```
      xinput list              # to find device id (15 here)
      xinput list-props 15     # to find the correct property number (279 here)
      xinput set-prop 15 279 1 # set natural scrolling on
      xinput set-prop 15 297 1 # set tap to click on
```

  Better way of doing it = to make these persistent, add the following to `/etc/X11/xorg.conf.d/30-touchpad.conf`:

```
      Section "InputClass"
              Identifier "libinput touchpad catchall"
              MatchIsTouchpad "on"
              Option "NaturalScrolling" "true"
              Option "Tapping" "true"
              Option "TappingButtonMap" "lrm"
      EndSection
```

- Making a lid close suspend ([source](https://www.reddit.com/r/i3wm/comments/5g86f1/suspend_on_lid_close/))
