#!/usr/bin/env sh

. "$HOME/suckless/scripts/bar_themes/catppuccin.sh"

printf "^c$main_color^ ^d^%.0f" "$(cat /sys/class/backlight/*/brightness)"
