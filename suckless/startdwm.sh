#!/usr/bin/env sh

xrandr
xset r rate 190 50

[[ -f ~/.Xresources ]] && xrdb -merge -I"$HOME" ~/.Xresources

feh --bg-fill "~/suckless/wallpaper/wallpaper2.png"
setxkbmap -model pc105 -layout br -variant abnt2

setsid "~/suckless/scripts/bar.sh" &>/dev/null &

while true; do
	dwm 2>~/.dwm.log
done
