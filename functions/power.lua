local power_sm = {}

power_sm.shutdown = function()
	if AwesomeWM.functions.clients.hasNotToKill() then
		return
	end

	if AwesomeWM.user then
		AwesomeWM.user.exit()
	end
	os.remove(AwesomeWM.values.restartFile)
	AwesomeWM.awful.spawn.with_shell("shutdown now")
end

power_sm.reboot = function()
	if AwesomeWM.functions.clients.hasNotToKill() then
		return
	end

	os.remove(AwesomeWM.values.restartFile)
	AwesomeWM.awful.spawn.with_shell("reboot")
end

power_sm.logout = function()
	if AwesomeWM.functions.clients.hasNotToKill() then
		return
	end

	AwesomeWM.awful.spawn.with_shell("kill -9 -1")
end

power_sm.lock = function()
	if AwesomeWM.functions.clients.hasNotToKill() then
		return
	end

	AwesomeWM.awful.spawn.with_shell("betterlockscreen -l")
end

power_sm.sleep = function()
	if AwesomeWM.functions.clients.hasNotToKill() then
		return
	end

	AwesomeWM.awful.spawn.with_shell("systemctl suspend && betterlockscreen -l")
end

return power_sm
