-- Widgets module

local module = {}

module.testWidget = function(text)
	return AwesomeWM.wibox.widget({
		{
			text = text,
			valign = 'center',
			align = 'center',
			widget = AwesomeWM.wibox.widget.textbox
		},
		bg = '#ff0000',
		widget = AwesomeWM.wibox.container.background,
	})
end

module.initWidgets = function()
	module.list = {
		volumeIndicator = require('widgets.indicators.volume'),
		brightnessIndicator = require('widgets.indicators.brightness'),
		tagsIndicator = require('widgets.indicators.tags'),
		systemInfo = require('widgets.systemInfo'),
		clientCount = require('widgets.clientCount'),
	}

end


return module
