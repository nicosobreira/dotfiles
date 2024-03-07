#!/bin/bash
# from Google drive to Local Folder
# rclone bisync google: ~/Google --resync --progress --log-file ~/.config/rclone/rclone.log
# rclone sync -v --create-empty-src-dirs ~/Google/ google:/games/data
rclone bisync google:/games/data ~/Games/games/data --resync --progress \
	--log-file ~/.config/rclone/logs/rclone.log
