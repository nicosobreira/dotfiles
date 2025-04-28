#!/usr/bin/env sh

xrandr
xset r rate 190 50
xrdb -merge "$HOME/.Xresources"

feh --bg-fill "$HOME/suckless/wallpaper/wallpaper2.png"
setxkbmap -model pc105 -layout br -variant abnt2

dwmblocks &

while true; do
	dwm 2>~/.dwm.log
done
