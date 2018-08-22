#!/bin/bash

# This script sets x to see and use my monitor, then fixes my background.
# TODO check monitor status first, then take the appropriate action

xrandr --output eDP1 --mode 1920x1080 --output HDMI1 --mode 2560x1440 --right-of eDP1

~/.fehbg
