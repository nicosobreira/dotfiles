local gears = require("gears")
local awful = require("awful")

local my_widgets = require("widgets")

globalkeys = gears.table.join(
	globalkeys,
	awful.key(
		{},
		"XF86MonBrightnessUp",
		my_widgets.bright.increase,
		{ description = "screen brightness up", group = "control" }
	),

	awful.key(
		{},
		"XF86MonBrightnessDown",
		my_widgets.bright.decrease,
		{ description = "screen brightness down", group = "control" }
	),

	awful.key(
		{},
		"XF86AudioRaiseVolume",
		my_widgets.volume.increase,
		{ description = "increase volume", group = "control" }
	),

	awful.key(
		{},
		"XF86AudioLowerVolume",
		my_widgets.volume.decrease,
		{ description = "decrease audio", group = "control" }
	),

	awful.key({}, "XF86AudioMute", my_widgets.volume.toggle, { description = "toggle audio mute", group = "control" })
)
