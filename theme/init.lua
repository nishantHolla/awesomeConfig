-- Theme module

local module = {}

module.theme_assets = require("beautiful.theme_assets")
module.xresources = require("beautiful.xresources")
module.dpi = module.xresources.apply_dpi

local b = AwesomeWM.beautiful

module.setWallpaper = function(_screen, _wallpaperPath)
	_screen = _screen or AwesomeWM.awful.screen.focused()
	_wallpaperPath = _wallpaperPath or AwesomeWM.assets.getWallpaper()

	AwesomeWM.gears.wallpaper.maximized(_wallpaperPath, _screen, true)
end

module.initTheme = function()

	b.font = 'SometypeMono NFM 12'

	b.useless_gap = module.dpi(3)
	b.border_width = module.dpi(3)
	b.border_normal = '#000000'
	b.border_focus = '#f20746'
	b.border_marked = '#91231c'
	
	b.notification_font = b.font
	b.notification_width = AwesomeWM.values.screenWidth
	b.notification_height = AwesomeWM.values.screenHeight
	b.notification_border_color = b.border_focus
	b.notification_border_width = b.border_width
end

return module
