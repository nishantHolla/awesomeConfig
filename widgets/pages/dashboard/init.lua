
local dashboard_sm = {}

local values_sm = AwesomeWM.widgets.pages.values
local helper_sm = AwesomeWM.widgets.pages.helper

dashboard_sm.components = {}
dashboard_sm.components.systemTray = require('widgets.pages.dashboard.components.systemTray')
dashboard_sm.components.time = require('widgets.pages.dashboard.components.time')
dashboard_sm.components.tags = require('widgets.pages.dashboard.components.tags')
dashboard_sm.components.powerOptions = require('widgets.pages.dashboard.components.powerOptions')
dashboard_sm.components.stats = require('widgets.pages.dashboard.components.stats')
dashboard_sm.components.userProfile = require('widgets.pages.dashboard.components.userProfile')
dashboard_sm.components.weather = require('widgets.pages.dashboard.components.weather')
dashboard_sm.components.media = require('widgets.pages.dashboard.components.media')
dashboard_sm.components.notes = require('widgets.pages.dashboard.components.notes')

dashboard_sm.init = function()
	dashboard_sm.left = require('widgets.pages.dashboard.left')
	dashboard_sm.middle = require('widgets.pages.dashboard.middle')
	dashboard_sm.right = require('widgets.pages.dashboard.right')

	dashboard_sm.main = AwesomeWM.wibox.widget({
		dashboard_sm.left.main,
		dashboard_sm.middle.main,
		dashboard_sm.right.main,
		spacing = values_sm.primarySpacing,
		layout = AwesomeWM.wibox.layout.ratio.horizontal
	})

	dashboard_sm.main:ajust_ratio(2, 0.25, 0.5, 0.25)

	dashboard_sm.wibox = AwesomeWM.wibox({
		widget = AwesomeWM.wibox.widget({
			dashboard_sm.main,
			margins = values_sm.primarySpacing,
			widget = AwesomeWM.wibox.container.margin
		}),
		visible = false,
		opacity = values_sm.wiboxOpacity,
		ontop = true,
		type = 'dock',
		bg =  values_sm.wiboxBg,
		height = AwesomeWM.values.screenHeight,
		width = AwesomeWM.values.screenWidth,
	})

	AwesomeWM.awful.placement.centered(dashboard_sm.wibox)

end

dashboard_sm.start = function()
	dashboard_sm.components.time.refresh()
	dashboard_sm.components.tags.refresh()
	dashboard_sm.components.stats.refresh()
	dashboard_sm.components.weather.refresh()
	dashboard_sm.components.media.refresh()
	dashboard_sm.components.notes.refresh()

	dashboard_sm.components.time.timer:start()
	dashboard_sm.components.media.timer:start()
end

dashboard_sm.stop = function()
	dashboard_sm.components.time.timer:stop()
	dashboard_sm.components.media.timer:stop()
end

dashboard_sm.toggle = function()
	dashboard_sm.wibox.visible = not dashboard_sm.wibox.visible

	if dashboard_sm.wibox.visible then
		dashboard_sm.start()
	else
		dashboard_sm.stop()
	end
end

return dashboard_sm
