#!/usr/bin/env bash

get_volume_symbol() {
	local sink="$1"
	local volume="$2"

	if ! [[ "$(pactl get-sink-mute "$sink")" =~ no ]]; then
		echo "󰖁"
		return
	fi
	
	volume=${volume%%%}
	if [[ "$volume" -lt 30 ]]; then
		echo "󰕿"
		return
	fi

	if [[ "$volume" -lt 60 ]]; then
		echo "󰖀"
		return
	fi

	echo "󰕾"
}

sink=0

volume=$(pactl get-sink-volume "$sink" | grep -Po "\b\d+(?:%)" | head -1)
volume_symbol="$(get_volume_symbol "$sink" "$volume")"

echo "${volume_symbol} ${volume}"
