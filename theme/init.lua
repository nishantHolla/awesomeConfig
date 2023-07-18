
local theme_m = {}
local imageExtensions = {'.jpg', '.png', '.jpeg'}

theme_m.theme_assets = require("beautiful.theme_assets")
theme_m.xresources = require("beautiful.xresources")
theme_m.dpi = theme_m.xresources.apply_dpi

local b = AwesomeWM.beautiful

theme_m.setWallpaper = function(_screen, _wallpaperPath)
	_screen = _screen or AwesomeWM.awful.screen.focused()
	_wallpaperPath = _wallpaperPath or AwesomeWM.assets.getWallpaper()

	AwesomeWM.gears.wallpaper.maximized(_wallpaperPath, _screen, false)
end

local function endsWith(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

local function isImage(_path)
	for _, ext in pairs(imageExtensions) do
		if endsWith(_path, ext) then return true end
	end

	return false
end

theme_m.replaceWallpaper = function(_screen, _wallpaperPath)
	_screen = _screen or AwesomeWM.awful.screen.focused()
	_wallpaperPath = _wallpaperPath or AwesomeWM.assets.getWallpaper()

	if isImage(_wallpaperPath) == false then return end

	AwesomeWM.awful.spawn.with_shell('cp -f ' .. _wallpaperPath .. ' ' .. AwesomeWM.assets.getWallpaper())
	AwesomeWM.gears.wallpaper.maximized(_wallpaperPath, _screen, false)
end

theme_m.initTheme = function()

	b.defaultFont = 'SometypeMono NFM'
	b.pagesFont = 'Quicksand'
	b.font = b.defaultFont .. ' 12'
	b.nerdFont = b.defaultFont

	b.redBright = '#F25050'
	b.redLight = '#F48282'
	b.redDark = '#F23838'

	b.blueBright = '#A85EF2'
	b.blueLight = '#CEA9F4'
	b.blueDark = '#1F2C73'

	b.greenBright = '#05F29B'
	b.greenLight = '#4EF4B7'
	b.greenDark = '#03A66A'

	b.yellowBright = '#FFD045'
	b.yellowLight = '#F4DA8B'
	b.yellowDark = '#F2C641'

	b.black = '#0F0F0F'
	b.gray = '#333333'
	b.white = '#F2F2F2'

	b.useless_gap = theme_m.dpi(3)
	b.border_width = theme_m.dpi(7)

	b.border_normal = b.black
	b.border_focus = b.redBright
	b.border_sticky = b.yellowBright
	b.border_marked = b.blueBright
	b.border_floating = b.greenBright
	b.border_fullscreen = b.blueBright

	b.notification_font = b.font
	b.notification_bg = b.blueDark
	b.notification_fg = b.blueLight
	b.notification_critical_bg = b.redDark
	b.notification_width = AwesomeWM.values.screenWidth
	b.notification_height = AwesomeWM.values.screenHeight * 0.1
	b.notification_border_color = b.border_normal
	b.notification_border_width = b.border_width

	b.tagIndicatorDeadBorderColor = b.gray
	b.tagIndicatorDeadBackground = b.black

	b.tagIndicatorActiveBorderColor = b.redBright
	b.tagIndicatorActiveBackground = b.redDark

	b.tagIndicatorAliveBorderColor = b.blueBright
	b.tagIndicatorAliveBackground = b.blueDark
end

return theme_m
