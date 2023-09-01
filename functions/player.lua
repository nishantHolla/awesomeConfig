
local player_sm = {}

player_sm.script = AwesomeWM.values.getScript('player')

local run = function(_command)
	AwesomeWM.awful.spawn.easy_async(_command, function(_stdout, _stderr, _errorReason, _exitCode)
	end)
end

player_sm.previous = function()
	run(player_sm.script .. ' previous')
end

player_sm.next = function()
	run(player_sm.script .. ' next')
end

player_sm.toggle = function()
	run(player_sm.script .. ' toggle')
end

player_sm.playTick = function()
	AwesomeWM.awful.spawn('paplay ' .. AwesomeWM.assets.getSound('tickSound') .. ' --volume=30000')
end

return player_sm
