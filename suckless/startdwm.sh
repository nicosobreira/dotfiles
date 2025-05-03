#!/usr/bin/env sh

xrandr
xset r rate 190 50

[ -f "$HOME/.Xresources" ] && xrdb -merge -I"$HOME" "$HOME/.Xresources"

feh --bg-fill "$HOME/suckless/wallpaper/wallpaper2.png" &

setxkbmap -model pc105 -layout br -variant abnt2

setsid "$HOME/suckless/scripts/bar.sh" &> /dev/null &

while true; do
	dwm 2> "$HOME/.dwm.log"
done
