# Start virtualenv wrapper (virtualfish)
eval (python3 -m virtualfish)

# Vim keybindings
fish_vi_key_bindings

# bobthefish options
set -g theme_display_vi no
set -g theme_nerd_fonts yes
set -g theme_date_format "+%a %H:%M"
set -g theme_display_cmd_duration no

source /home/kyeb/.config/fish/shortcuts.fish

set -gx NNN_USE_EDITOR 1

# Setting consistent PATH
set PATH /home/kyeb/.scripts /home/kyeb/.cargo/bin /home/kyeb/.local/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /snap/bin /usr/local/texlive/2019/bin/x86_64-linux
