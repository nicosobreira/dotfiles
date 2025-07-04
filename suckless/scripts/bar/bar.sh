#!/usr/bin/env dash

. "$HOME/suckless/scripts/bar_themes/catppuccin.sh"

get_battery() {
	if [ "$(cat /sys/class/power_supply/BAT1/status)" = "Charging" ]; then
		battery_symbol="^c$green^󰂄 ^d^"
	else
		battery_symbol="^c$main_color^󰁹 ^d^"
	fi

	printf "$battery_symbol%s%%" "$(cat /sys/class/power_supply/BAT1/capacity)"
}

get_brightness() {
	printf "^c$main_color^ ^d^%.0f" "$(cat /sys/class/backlight/*/brightness)"
}

get_memory() {
	printf "^c$main_color^ ^d^%s" "$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

get_date() {
	printf "^c$main_color^ ^d^%s" "$(date "+%m/%d")"
}

get_time() {
	printf "^c$main_color^ ^d^%s" "$(date "+%H:%M")"
}

get_volume() {
	volume="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po "\b\d+(?:%)" | head -1)"

	volume="${volume%%%}"
	if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: yes" ]; then
		volume_symbol="^c$red^󰖁 ^d^"
	else
		if [ "$volume" -lt 30 ]; then
			volume_symbol="^c$main_color^󰕿 ^d^"
		elif [ "$volume" -lt 60 ]; then
			volume_symbol="^c$main_color^󰖀 ^d^"
		else
			volume_symbol="^c$main_color^󰕾 ^d^"
		fi
	fi
	
	printf "${volume_symbol}${volume}%%"
}

while true; do
	sleep 1 && xsetroot -name "$(get_volume) | $(get_battery) | $(get_brightness) | $(get_memory) | $(get_date) | $(get_time)"
done
