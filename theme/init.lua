-- Theme module

local module = {}

module.theme_assets = require("beautiful.theme_assets")
module.xresources = require("beautiful.xresources")
module.dpi = module.xresources.apply_dpi

local b = AwesomeWM.beautiful

module.setWallpaper = function(_screen, _wallpaperPath)
	_screen = _screen or AwesomeWM.awful.screen.focused()
	_wallpaperPath = _wallpaperPath or AwesomeWM.assets.getWallpaper()

	AwesomeWM.gears.wallpaper.maximized(_wallpaperPath, _screen, false)
end

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

module.replaceWallpaper = function(_screen, _wallpaperPath)
	_screen = _screen or AwesomeWM.awful.screen.focused()

	if _wallpaperPath == nil then
		AwesomeWM.notify.normal('a', 'b')
		return
	end
	if AwesomeWM.functions.isFile(_wallpaperPath) == false then return end
	if ends_with(_wallpaperPath, ".jpg") == false then return end

	local currentWallpaperPath = AwesomeWM.assets.getWallpaper()

	AwesomeWM.awful.spawn.with_shell('rm ' .. currentWallpaperPath)
	AwesomeWM.awful.spawn.with_shell('cp ' .. _wallpaperPath .. ' ' .. currentWallpaperPath)
	module.setWallpaper(nil, _wallpaperPath)

end

module.initTheme = function()

	b.defaultFont = 'SometypeMono NFM'
	b.dashBoardFont = 'Quicksand'
	b.font = b.defaultFont .. ' 12'

	b.redLight = "#ff8785"
	b.redDark = "#f50746"

	b.greenLight = "#A1FF7B"
	b.greenDark = "#69eb36"

	b.blueLight = "#A7E7F6"
	b.blueDark = "#18b8db"

	b.yellowLight = "#F0C56B"
	b.yellowDark = "#fab725"

	b.black = '#000000'
	b.blackLight = '#333333'
	b.white = '#000000'

	b.useless_gap = module.dpi(3)
	b.border_width = module.dpi(7)
	b.border_normal = b.blackLight
	b.border_focus = b.redDark
	b.border_sticky = b.yellowDark
	b.border_marked = b.blueDark
	b.border_floating = b.greenDark
	b.border_fullscreen = b.blueDark

	b.notification_font = b.font
	b.notification_bg = b.blueLight
	b.notification_fg = b.blackLight
	b.notification_critical_bg = b.redLight
	b.notification_width = AwesomeWM.values.screenWidth
	b.notification_height = AwesomeWM.values.screenHeight * 0.1
	b.notification_border_color = b.border_normal
	b.notification_border_width = b.border_width

	b.tagIndicatorDead = b.blackLight
	b.tagIndicatorActive = b.redDark
	b.tagIndicatorAlive = b.blueDark
end

return module
