
local module = {}

module.script = AwesomeWM.values.getScript('player')

local run = function(_command)
	AwesomeWM.awful.spawn.easy_async(_command, function(_stdout, _stderr, _errorReason, _exitCode)
	end)
end

module.previous = function()
	run(module.script .. ' previous')
end

module.next = function()
	run(module.script .. ' next')
end

module.toggle = function()
	run(module.script .. ' toggle')
end

return module
