
local maxValue = 255
local module = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.left,
	maxValue,
	AwesomeWM.beautiful.blueLight,
	AwesomeWM.beautiful.blueDark
)

module.show = function()

	AwesomeWM.functions.brightness.findBrightnessAnd(function(_icon, _brightness)
		local value = _brightness / maxValue * 100
		value = math.floor(value)

		module.slider.value = _brightness
		module.icon.image = _icon
		module.value.text = tostring(value) .. "%"
		module.wibox.show()
	end)
end

return module
