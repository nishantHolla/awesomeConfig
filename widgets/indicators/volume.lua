
local maxValue =  100
local module = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.right,
	maxValue,
	AwesomeWM.beautiful.redLight,
	AwesomeWM.beautiful.redDark
)

module.maxValue = maxValue

module.show = function()

	AwesomeWM.functions.volume.findVolumeAnd(function(_icon, _volume)
		local value = _volume / maxValue * 100
		value = math.floor(value)
		module.slider.value = _volume
		module.icon.image = _icon
		module.value.text = tostring(value) .. "%"
		module.wibox.show()
	end)

end

return module
