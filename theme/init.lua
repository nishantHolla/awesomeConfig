local theme_m = {}
local imageExtensions = { ".jpg", ".png", ".jpeg" }

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
		if endsWith(_path, ext) then
			return true
		end
	end

	return false
end

theme_m.replaceWallpaper = function(_screen, _wallpaperPath)
	_screen = _screen or AwesomeWM.awful.screen.focused()
	_wallpaperPath = _wallpaperPath or AwesomeWM.assets.getWallpaper()

	if isImage(_wallpaperPath) == false then
		return
	end

	AwesomeWM.awful.spawn.with_shell("cp -f " .. _wallpaperPath .. " " .. AwesomeWM.assets.getWallpaper())
	AwesomeWM.gears.wallpaper.maximized(_wallpaperPath, _screen, false)
end

theme_m.initTheme = function()
	b.defaultFont = "SometypeMono NFM"
	b.pagesFont = "Quicksand"
	b.font = b.defaultFont .. " 12"
	b.nerdFont = b.defaultFont

	b.white = "#F0F1DF"
	b.gray = "#2A2D30"
	b.black = "#0D0D0D"

	b.red = "#F0504F"
	b.blue = "#846FF7"
	b.green = "#70E0BB"
	b.yellow = "#F2D475"
	b.orange = "#F5793B"

	b.useless_gap = theme_m.dpi(3)
	b.border_width = theme_m.dpi(7)

	b.border_normal = b.black
	b.border_focus = b.red
	b.border_sticky = b.yellow
	b.border_marked = b.orange
	b.border_floating = b.green
	b.border_fullscreen = b.blue

	b.notification_font = b.font
	b.notification_bg = b.black
	b.notification_fg = b.white
	b.notification_opacity = 0.7
	b.notification_critical_bg = b.red
	b.notification_critical_fg = b.black
	b.notification_width = AwesomeWM.values.screenWidth * 0.3
	b.notification_height = AwesomeWM.values.screenHeight * 0.15
	b.notification_border_color = b.white
	b.notification_border_width = theme_m.dpi(20)

	b.tagIndicatorDeadBorderColor = b.gray
	b.tagIndicatorDeadBackground = b.gray

	b.tagIndicatorActiveBorderColor = b.red
	b.tagIndicatorActiveBackground = b.red

	b.tagIndicatorAliveBorderColor = b.blue
	b.tagIndicatorAliveBackground = b.blue
end

return theme_m
