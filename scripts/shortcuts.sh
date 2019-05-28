#!/bin/bash
# source: https://github.com/LukeSmithxyz/voidrice/blob/master/.scripts/shortcuts.sh

# Shell rc file (i.e. bash vs. zsh, etc.)
shellrc="$HOME/.config/fish/config.fish"

# Config locations
folders="$HOME/.scripts/folders"
configs="$HOME/.scripts/configs"

# Output locations
shell_shortcuts="$HOME/.config/fish/shortcuts.fish"
ranger_shortcuts="$HOME/.config/ranger/shortcuts.conf"

# Remove
rm -f "$shell_shortcuts" "$ranger_shortcuts" 

# Ensuring that output locations are properly sourced
(grep "source $shell_shortcuts"  "$shellrc")>/dev/null || echo "source $shell_shortcuts" >> "$shellrc"
(grep "source ~/.config/ranger/shortcuts.conf" "$HOME/.config/ranger/rc.conf")>/dev/null || echo "source ~/.config/ranger/shortcuts.conf" >> "$HOME/.config/ranger/rc.conf"

# Format the `folders` file in the correct syntax and sent it to all three configs.
sed "/^#/d" "$folders" | tee >(awk '{print "abbr "$1" \"cd "$2"; and  ls -a\""}' >> "$shell_shortcuts") \
	| awk '{print "map g"$1" cd "$2"\nmap t"$1" tab_new "$2"\nmap m"$1" shell mv -v %s "$2"\nmap Y"$1" shell cp -rv %s "$2}' >> "$ranger_shortcuts"


# Format the `configs` file in the correct syntax and sent it to both configs.
#sed "/^#/d" "$configs" | tee >(awk '{print "abbr "$1" \"$EDITOR "$2"\""}' >> "$shell_shortcuts") \
#	| awk '{print "map "$1" shell $EDITOR "$2}' >> "$ranger_shortcuts"

