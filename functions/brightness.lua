
local brightness_sm = {}

brightness_sm.script = AwesomeWM.values.getScript('brightness')

local run = function(_command)
	AwesomeWM.awful.spawn.easy_async(_command, function(_stdout, _stderr, _errorReason, _exitCode)
		AwesomeWM.widgets.indicators.brightness.show()
	end)
end

brightness_sm.get = function()
	return (brightness_sm.script .. ' get')
end

brightness_sm.increase = function()
	run(brightness_sm.script .. ' set 5+')
end

brightness_sm.decrease = function()
	run(brightness_sm.script .. ' set 5-')
end

brightness_sm.set = function(_value)
	run(brightness_sm.script .. ' set ' .. tostring(_value) )
end

brightness_sm.findBrightnessAnd = function(_function)
	if type(_function) ~= 'function' then return end

	AwesomeWM.awful.spawn.easy_async(brightness_sm.get(), function(_stdout, _stderr, _errorReason, _exitCode)
		local brightness = tonumber(_stdout)
		local icon = AwesomeWM.assets.getBrightnessIcon(brightness)

		_function(icon, brightness)
	end)

end


return brightness_sm
