
local module = {}

module.script = AwesomeWM.values.getScript('brightness')

local run = function(_command)
	AwesomeWM.awful.spawn.easy_async(_command, function(_stdout, _stderr, _errorReason, _exitCode)
		AwesomeWM.widgets.list.brightnessIndicator.show()
	end)
end

module.get = function()
	return (module.script .. ' get')
end

module.increase = function()
	run(module.script .. ' set 5+')
end

module.decrease = function()
	run(module.script .. ' set 5-')
end

module.set = function(_value)
	run(module.script .. ' set ' .. tostring(_value) )
end

module.findBrightnessAnd = function(_function)
	if type(_function) ~= 'function' then return end

	AwesomeWM.awful.spawn.easy_async(module.get(), function(_stdout, _stderr, _errorReason, _exitCode)
		local brightness = tonumber(_stdout)
		local icon = AwesomeWM.assets.getBrightnessIcon(brightness)

		_function(icon, brightness)
	end)

end


return module
