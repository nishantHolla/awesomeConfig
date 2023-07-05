
local maxValue =  100
local module = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.right,
	maxValue,
	AwesomeWM.beautiful.redLight,
	AwesomeWM.beautiful.redDark
)

module.maxValue = maxValue

module.show = function()

	AwesomeWM.awful.spawn.easy_async(AwesomeWM.functions.volume.get(), function(_stdout, _stderr, _errorReason, _exitCode)
		local volume = tonumber(_stdout)
		local icon = nil

		if volume > 75 then
			icon = AwesomeWM.assets.getIcon('volumeHighWhite')
		elseif volume > 25 then
			icon = AwesomeWM.assets.getIcon('volumeMediumWhite')
		elseif volume > 0 then
			icon = AwesomeWM.assets.getIcon('volumeLowWhite')
		else
			icon = AwesomeWM.assets.getIcon('volumeMuteWhite')
		end

		local value = volume / maxValue * 100
		value = math.floor(value)
		module.slider.value = volume
		module.icon.image = icon
		module.value.text = tostring(value) .. "%"
		module.wibox.show()

	end)

end

return module
