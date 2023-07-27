
local maxValue =  100
local indicatorVolume_sm = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.right,
	maxValue,
	AwesomeWM.beautiful.white,
	AwesomeWM.beautiful.red
)

indicatorVolume_sm.maxValue = maxValue

indicatorVolume_sm.show = function()

	AwesomeWM.functions.volume.findVolumeAnd(function(_icon, _volume)
		local value = _volume / maxValue * 100
		value = math.floor(value)
		indicatorVolume_sm.slider.value = _volume
		indicatorVolume_sm.icon.image = _icon
		indicatorVolume_sm.value.text = tostring(value) .. "%"
		indicatorVolume_sm.wibox.show()
	end)

end

return indicatorVolume_sm
