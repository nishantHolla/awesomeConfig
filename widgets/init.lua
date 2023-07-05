-- Widgets module

local module = {}

module.initWidgets = function()
	module.list = {
		volumeIndicator = require('widgets.indicators.volume'),
		brightnessIndicator = require('widgets.indicators.brightness'),
		tagsIndicator = require('widgets.indicators.tags'),
		systemInfo = require('widgets.systemInfo')
	}


end


return module
