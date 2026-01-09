pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

local ui_utils = require("ui.utils")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local settings = require("settings")

-- Config the default notification preset
naughty.config.presets.low = {
	position = "bottom_right"
}

naughty.config.presets.normal = {
	position = "bottom_right"
}

naughty.config.presets.critical = {
	position = "bottom_right"
}

-- Theme init
local config_dir = gears.filesystem.get_configuration_dir()
local custom_theme = string.format("%sthemes/%s/theme.lua", config_dir, settings.theme_name)

if not beautiful.init(custom_theme) then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "ERROR while loading custom theme:",
		text = string.format("Path: %s", custom_theme),
	})
	beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
end

-- Custom modules
local my_tags = require("tags")
local my_widgets = require("widgets")

-- Custom variables
local modkey = settings.modkey

require("signals")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.max,
	awful.layout.suit.floating,
	awful.layout.suit.tile.bottom,
}

-- {{{ Menu
-- Create a launcher widget and a main menu

Mymainmenu = awful.menu({
	items = {
		{
			"hotkeys",
			function()
				hotkeys_popup.show_help(nil, awful.screen.focused())
			end,
		},
		{ "restart", awesome.restart },
		{
			"quit",
			function()
				awesome.quit()
			end,
		},
	},
})

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = Mymainmenu })

-- }}}

-- {{{ Wibar
-- Create a textclock widget

local my_calendar = wibox.widget({
	{
		id = "icon",
		font = ui_utils.font_resize(12),
		markup = " ",
		align = "center",
		valing = "center",
		widget = wibox.widget.textbox,
	},
	{
		id = "date",
		format = "%d/%m",
		refresh = 600,
		widget = wibox.widget.textclock,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

local my_time = wibox.widget({
	{
		id = "icon",
		font = ui_utils.font_resize(12),
		markup = " ",
		align = "center",
		valing = "center",
		widget = wibox.widget.textbox,
	},
	{
		id = "date",
		format = "%H:%M",
		widget = wibox.widget.textclock,
	},
	spacing = settings.spacing,
	layout = wibox.layout.fixed.horizontal,
})

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if not beautiful.wallpaper then
		gears.wallpaper.set(beautiful.bg_normal)
		return
	end

	local wallpaper = beautiful.wallpaper

	-- If wallpaper is a function, call it with the screen
	if type(wallpaper) == "function" then
		wallpaper = wallpaper(s)
	end

	gears.wallpaper.maximized(wallpaper, s, true)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag(my_tags.get_all(), s, awful.layout.suit.max)

	-- Coding in titled
	s.tags[1].layout = awful.layout.suit.tile

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ screen = s, position = "top" })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			spacing = beautiful.get_font_height(beautiful.font),
			wibox.widget.systray(),
			-- my_widgets.pomodoro.widget,
			my_widgets.bright.widget,
			my_widgets.volume.widget,
			my_widgets.battery,
			my_calendar,
			my_time,
			s.mylayoutbox,
		},
	})
end)
-- }}}

require("bindings")

require("rules")
