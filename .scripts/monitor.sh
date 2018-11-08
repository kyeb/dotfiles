#!/bin/bash

# This script sets x to see and use my monitor, then fixes my background.
# Usage: Add the directory of this script to your path, and make sure that the
# file is executablee (`chmod +x ~/.scripts/monitor`)
# `monitor` without arguments will check if a monitor is connected and do one
# of two things:
#   - Run `xrandr --auto` if it doesn't recognize the setup
#   - If it recognizes my home setup, run the dual monitor setup command
#
# Finally, it fixes wallpapers using `nitrogen --restore`. 

xrandr --auto

if [[ `xrandr | grep "HDMI1 connected 2560x1440"` != "" ]] && [[ "$1" = "only" ]]; then
    echo "Mode: monitor only"
    xrandr --output eDP1 --off --output HDMI1 --mode 2560x1440 --right-of eDP1
elif xrandr | grep -q "HDMI1 connected 2560x1440"; then
    echo "Mode: display and monitor"
    xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 2560x1440 --left-of eDP1
else
    echo "Mode: auto"
fi

sleep 0.2

nitrogen --restore

