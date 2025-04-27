#!/usr/bin/env sh

feh --bg-fill "$HOME/suckless/wallpaper/wallpaper2.png"
setxkbmap -model pc105 -layout br -variant abnt2
xset r rate 190 50

dwmblocks &

while true; do
	dwm 2>~/.dwm.log
done
