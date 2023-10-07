local widgets_m = {}

widgets_m.testWidget = function(text)
	return AwesomeWM.wibox.widget({
		text = text,
		valign = "center",
		align = "center",
		widget = AwesomeWM.wibox.widget.textbox,
	})
end

widgets_m.initWidgets = function()
	widgets_m.indicators = {}
	widgets_m.indicators.volume = require("widgets.indicators.volume")
	widgets_m.indicators.brightness = require("widgets.indicators.brightness")
	widgets_m.indicators.tags = require("widgets.indicators.tags")
	widgets_m.indicators.clientCount = require("widgets.indicators.clientCount")
	widgets_m.indicators.time = require("widgets.indicators.time")

	widgets_m.lowBattery = require("widgets.lowBattery")
	widgets_m.lowBattery.init()

	widgets_m.pages = {}
	widgets_m.pages.values = require("widgets.pages.values")
	widgets_m.pages.helper = require("widgets.pages.helper")
	widgets_m.pages.dashboard = require("widgets.pages.dashboard")

	widgets_m.pages.dashboard.init()
end

return widgets_m
