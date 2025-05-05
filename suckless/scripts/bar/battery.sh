#!/usr/bin/env sh

. "$HOME/suckless/scripts/bar_themes/catppuccin.sh"

battery_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"

if [ "$(cat /sys/class/power_supply/BAT1/status)" = "Charging" ]; then
	battery_symbol="^c$green^󰂄 ^d^"
else
	if [ "$battery_capacity" -le 35 ]; then
		battery_symbol="^c$red^󱊡 ^d^"
	elif [ "$battery_capacity" -le 65 ]; then
		battery_symbol="^c$yellow^󱊢 ^d^"
	else
		battery_symbol="^c$main_color^󱊣 ^d^"
	fi
fi

printf "$battery_symbol%s%%" "$battery_capacity"
