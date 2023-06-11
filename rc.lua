
AwesomeWM = {}

-- awesome modules

AwesomeWM.luarocks = pcall(require, 'luarocks.loader')
AwesomeWM.awesome = awesome
AwesomeWM.gears = require('gears')
AwesomeWM.awful = require('awful')
AwesomeWM.wibox = require('wibox')
AwesomeWM.beautiful = require('beautiful')
AwesomeWM.naughty = require('naughty')
AwesomeWM.menubar = require('menubar')
AwesomeWM.hotkeysPopup = require('awful.hotkeys_popup')
AwesomeWM.hotkeysPopupKeys = require('awful.hotkeys_popup.keys')

-- user modules

AwesomeWM.notify = require('notify')
AwesomeWM.functions = require('functions')

-- inits

AwesomeWM.functions.initErrorHandling()
