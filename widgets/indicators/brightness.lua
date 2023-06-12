
local module = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.left,
	255,
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

		module.slider.value = brightness
		module.icon.image = icon
		module.value.text = _stdout
		module.wibox.show()
	end)
end

return module
