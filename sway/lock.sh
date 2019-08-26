#!/bin/bash

grim /tmp/lockscreen.png 
convert /tmp/lockscreen.png -paint 1.5 /tmp/lockscreen-painted.png
swaylock -f -i /tmp/lockscreen-painted.png

