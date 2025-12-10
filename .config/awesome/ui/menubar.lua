local menubar = require("menubar")

local settings = require("settings")

-- Menubar configuration
menubar.utils.terminal = settings.terminal -- Set the terminal for applications that require it
menubar.show_categories = false

return menubar
