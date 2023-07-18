
local widgets_m = {}

widgets_m.testWidget = function(text)
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

widgets_m.initWidgets = function()
	widgets_m.list = {
		volumeIndicator = require('widgets.indicators.volume'),
		brightnessIndicator = require('widgets.indicators.brightness'),
		tagsIndicator = require('widgets.indicators.tags'),
		clientCount = require('widgets.clientCount'),
	}


end


return widgets_m
