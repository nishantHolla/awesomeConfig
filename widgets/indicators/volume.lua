
local module = require('widgets.indicators.base').make(
	AwesomeWM.awful.placement.right,
	100,
	AwesomeWM.beautiful.redLight,
	AwesomeWM.beautiful.redDark
)


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

		module.slider.value = volume
		module.icon.image = icon
		module.value.text = _stdout
		module.wibox.show()

	end)

end

return module
