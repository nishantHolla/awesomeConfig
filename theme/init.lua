-- Theme module

local module = {}

module.theme_assets = require("beautiful.theme_assets")
module.xresources = require("beautiful.xresources")
module.dpi = module.xresources.apply_dpi

local b = AwesomeWM.beautiful

module.initTheme = function()

	b.font = 'SometypeMono NFM 12'

	b.useless_gap = module.dpi(3)
	b.border_width = module.dpi(2)
	b.border_normal = '#000000'
	b.border_focus = '#ffffff'
	b.border_marked = '#91231c'
	
	b.notification_font = b.font
	b.notification_width = AwesomeWM.values.screenWidth
	b.notification_height = AwesomeWM.values.screenHeight
	b.notification_border_color = b.border_focus
	b.notification_border_width = b.border_width
end

return module
