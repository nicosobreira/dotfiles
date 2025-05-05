#!/usr/bin/env sh

. "$HOME/suckless/scripts/bar_themes/catppuccin.sh"

printf "^c$main_color^ ^d^%s" "$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
