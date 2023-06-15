
AwesomeWM = {}

-- awesome modules

AwesomeWM.luarocks = pcall(require, 'luarocks.loader')
AwesomeWM.awesome = awesome
AwesomeWM.root = root
AwesomeWM.screen = screen
AwesomeWM.tag = tag
AwesomeWM.client = client
AwesomeWM.gears = require('gears')
AwesomeWM.awful = require('awful')
AwesomeWM.autofocus = require('awful.autofocus')
AwesomeWM.wibox = require('wibox')
AwesomeWM.beautiful = require('beautiful')
AwesomeWM.naughty = require('naughty')
AwesomeWM.menubar = require('menubar')
AwesomeWM.hotkeysPopup = require('awful.hotkeys_popup')
AwesomeWM.hotkeysPopupKeys = require('awful.hotkeys_popup.keys')

-- user modules

AwesomeWM.values = require('values')
AwesomeWM.functions = require('functions')
AwesomeWM.assets = require('assets')
AwesomeWM.keymaps = require('keymaps')
AwesomeWM.notify = require('notify')
AwesomeWM.theme = require('theme')
AwesomeWM.widgets = require('widgets')

-- inits

AwesomeWM.functions.initErrorHandling()
AwesomeWM.values.initValues()
AwesomeWM.functions.initScreens()
AwesomeWM.keymaps.initKeymaps()
AwesomeWM.theme.initTheme()
AwesomeWM.functions.initClients()
AwesomeWM.widgets.initWidgets()

AwesomeWM.widgets.list.tagsIndicator.show()
