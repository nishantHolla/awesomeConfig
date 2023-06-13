-- Widgets module

local module = {}

module.initWidgets = function()
	module.list = {
		volumeIndicator = require('widgets.indicators.volume'),
		brightnessIndicator = require('widgets.indicators.brightness'),
		systemInfo = require('widgets.systemInfo')
	}

	module.list.systemInfo.refresh()
end

return module
