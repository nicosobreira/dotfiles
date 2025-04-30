#!/usr/bin/env bash

set -eou pipefail

get_battery() {
	printf " %s%%" $(cat /sys/class/power_supply/BAT2/capacity)
}

get_brightness() {
	printf " %.0f" $(cat /sys/class/backlight/*/brightness)
}

get_memory() {
	printf " %s" $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)
}

get_date() {
	printf " %s" $(date "+%m/%d")
}

get_time() {
	printf " %s" $(date "+%H:%M")
}

get_volume() {
	local sink=0
	local volume=""
	local volume_symbol=""

	volume=$(pactl get-sink-volume "$sink" | grep -Po "\b\d+(?:%)" | head -1)

	volume=${volume%%%}
	if [[ "$(pactl get-sink-mute "$sink")" =~ no ]]; then
		if [[ "$volume" -lt 30 ]]; then
			volume_symbol="󰕿"
		elif [[ "$volume" -lt 60 ]]; then
			volume_symbol="󰖀"
		else
			volume_symbol="󰕾"
		fi
	else
		volume_symbol="󰖁"
	fi
	
	printf "${volume_symbol} ${volume}%%"
}

while true; do
	xsetroot -name " $(get_volume) | $(get_brightness) | $(get_memory) | $(get_date) | $(get_time) "
	sleep 1
done
