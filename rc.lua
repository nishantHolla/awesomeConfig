AwesomeWM = {}

-- awesome modules

AwesomeWM.luarocks = pcall(require, "luarocks.loader")
AwesomeWM.awesome = awesome
AwesomeWM.root = root
AwesomeWM.screen = screen
AwesomeWM.tag = tag
AwesomeWM.client = client
AwesomeWM.gears = require("gears")
AwesomeWM.awful = require("awful")
AwesomeWM.autofocus = require("awful.autofocus")
AwesomeWM.wibox = require("wibox")
AwesomeWM.beautiful = require("beautiful")
AwesomeWM.naughty = require("naughty")
AwesomeWM.menubar = require("menubar")
AwesomeWM.hotkeysPopup = require("awful.hotkeys_popup")
AwesomeWM.hotkeysPopupKeys = require("awful.hotkeys_popup.keys")

-- user modules

AwesomeWM.values = require("values")
AwesomeWM.functions = require("functions")
AwesomeWM.notify = require("notify")
AwesomeWM.assets = require("assets")
AwesomeWM.keymaps = require("keymaps")
AwesomeWM.theme = require("theme")
AwesomeWM.widgets = require("widgets")

-- User module (ignored by git)
_, AwesomeWM.user = pcall(require, "user")

-- inits

AwesomeWM.functions.initErrorHandling()
AwesomeWM.values.initValues()
AwesomeWM.functions.screens.initScreens()
AwesomeWM.keymaps.initKeymaps()
AwesomeWM.theme.initTheme()
AwesomeWM.functions.clients.initClients()
AwesomeWM.widgets.initWidgets()
AwesomeWM.notify.initNotifications()
AwesomeWM.functions.initRestore()

-- User functions (ignored by git)
-- to use this, create a file called user.lua in functions directory and return a table that
-- has a function called run. The run functions will be called every time awesome startsup
if AwesomeWM.user then
	AwesomeWM.user.init()
end

AwesomeWM.widgets.indicators.tags.show()
