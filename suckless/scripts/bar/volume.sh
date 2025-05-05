#!/usr/bin/env sh

. "$HOME/suckless/scripts/bar_themes/catppuccin.sh"

volume="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po "\b\d+(?:%)" | head -1)"

volume="${volume%%%}"
if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: yes" ]; then
	volume_symbol="^c$red^󰖁 ^d^"
else
	if [ "$volume" -lt 25 ]; then
		volume_symbol="^c$main_color^󰕿 ^d^"
	elif [ "$volume" -lt 65 ]; then
		volume_symbol="^c$main_color^󰖀 ^d^"
	else
		volume_symbol="^c$main_color^󰕾 ^d^"
	fi
fi

printf "${volume_symbol}${volume}%%"
