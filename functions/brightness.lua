
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


return module
