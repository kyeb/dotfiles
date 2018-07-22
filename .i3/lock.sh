#!/bin/bash

# Approximate timeout rate in milliseconds (checked every 5 seconds).
timeout="30000"

# Take a screenshot of every screen available:
scrot -m -z /tmp/lock.png
xdpyinfo -ext XINERAMA | sed '/^  head #/!d;s///' |
{
  cmd="convert /tmp/lock.png"
	cmdend=""
  while IFS=' :x@,' read i w h x y; do
    cmd+=" -region ${w}x$h+$x+$y -paint 2"
    xc=$((x+(w/2)-79))
    yc=$((y+(h/2)-79))
    cmdend+=" ~/.i3/lock.png  -geometry +${xc}+${yc} -composite -matte"
  done
  cmd+="${cmdend} /tmp/screen.png"

  eval $cmd
}

# Lock it up!
i3lock -e -f -c 000000 -i /tmp/screen.png

# If still locked after $timeout milliseconds, turn off screen.
while [[ $(pgrep -x i3lock) ]]; do
  [[ $timeout -lt $(xssstate -i) ]] && systemctl suspend
  sleep 5
done

