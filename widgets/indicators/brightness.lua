
local maxValue = 255
local module = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.left,
	maxValue,
	AwesomeWM.beautiful.blueLight,
	AwesomeWM.beautiful.blueDark
)

module.show = function()

	AwesomeWM.awful.spawn.easy_async(AwesomeWM.functions.brightness.get(), function(_stdout, _stderr, _errorReason, _exitCode)
		local brightness = tonumber(_stdout)
		local icon = nil

		if brightness > 180 then
			icon = AwesomeWM.assets.getIcon('brightnessHighWhite')
		elseif brightness > 80 then
			icon = AwesomeWM.assets.getIcon('brightnessMediumWhite')
		else
			icon = AwesomeWM.assets.getIcon('brightnessLowWhite')
		end

		local value = brightness / maxValue * 100
		value = math.floor(value)

		module.slider.value = brightness
		module.icon.image = icon
		module.value.text = tostring(value) .. "%"
		module.wibox.show()
	end)
end

return module
