
local module = {}

module.script = AwesomeWM.values.getScript('volume')


local run = function(_command)
	AwesomeWM.awful.spawn.easy_async(_command, function(_stdout, _stderr, _errorReason, _exitCode)
		AwesomeWM.widgets.list.volumeIndicator.show()
	end)

end

-- volume function

module.get = function()
	return (module.script .. ' get')
end

module.increase = function()
	run(module.script .. ' set 5%+')
end

module.decrease = function()
	run(module.script .. ' set 5%-')
end

module.toggle = function()
	run(module.script .. ' toggle')
end

module.mute = function()
	run(module.script .. ' mute')
end

module.unmute = function()
	run(module.script .. ' unmute')
end

return module
