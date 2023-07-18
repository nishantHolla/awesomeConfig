
local maxValue = 255

local indicatorBrightness_sm = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.left,
	maxValue,
	AwesomeWM.beautiful.blueLight,
	AwesomeWM.beautiful.blueDark
)

indicatorBrightness_sm.show = function()

	AwesomeWM.functions.brightness.findBrightnessAnd(function(_icon, _brightness)
		local value = _brightness / maxValue * 100
		value = math.floor(value)

		indicatorBrightness_sm.slider.value = _brightness
		indicatorBrightness_sm.icon.image = _icon
		indicatorBrightness_sm.value.text = tostring(value) .. "%"
		indicatorBrightness_sm.wibox.show()
	end)
end

return indicatorBrightness_sm
