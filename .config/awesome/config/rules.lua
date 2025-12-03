local awful = require("awful")
local gears = require("gears")

local my_tags = require("config.my_tags")

awful.rules.rules = gears.table.join(
	awful.rules.rules,
	-- Browsers
	{
		rule = { class = { "Firefox", "Vivaldi", "Chromium", "Browser", "Brave" } },
		properties = { screen = 1, tag = my_tags.get(2) },
	},

	-- Games
	{
		rule = { class = { "Steam", "Retroarch", "pcsx2-qt" } },
		properties = { screen = 1, tag = my_tags.get(3) },
	},

	-- Security
	{
		rule = { class = { "KeePassXC" } },
		properties = { screen = 1, tag = my_tags.get(5) },
	}
)
