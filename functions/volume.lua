
local volume_sm = {}

volume_sm.script = AwesomeWM.values.getScript('volume')


local run = function(_command)
	AwesomeWM.awful.spawn.easy_async(_command, function(_stdout, _stderr, _errorReason, _exitCode)
		AwesomeWM.widgets.indicators.volume.show()
	end)

end

-- volume function

volume_sm.get = function()
	return (volume_sm.script .. ' get')
end

volume_sm.increase = function()
	run(volume_sm.script .. ' set 5%+')
end

volume_sm.decrease = function()
	run(volume_sm.script .. ' set 5%-')
end

volume_sm.toggle = function()
	run(volume_sm.script .. ' toggle')
end

volume_sm.mute = function()
	run(volume_sm.script .. ' mute')
end

volume_sm.unmute = function()
	run(volume_sm.script .. ' unmute')
end

volume_sm.findVolumeAnd = function(_function)
	if type(_function) ~= "function" then return end

	AwesomeWM.awful.spawn.easy_async(AwesomeWM.functions.volume.get(), function(_stdout, _stderr, _errorReason, _exitCode)
		local volume = tonumber(_stdout)
		local icon = AwesomeWM.assets.getVolumeIcon(volume)

		_function(icon, volume)
	end)

end


return volume_sm
