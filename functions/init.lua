-- Functions module

local module = {}

module.initErrorHandling = function()

	-- startup errors
	if AwesomeWM.awesome.startup_errors then

		AwesomeWM.notify.critical('Startup error encountered', AwesomeWM.awesome.startup_errors)
	end

	-- runtime errors
	do
		local inError = false
		AwesomeWM.awesome.connect_signal('debug::error', function(errorMessage)
			if inError then return end
			inError = true

			AwesomeWM.notify.critical('Runtime error encountered', tostring(errorMessage))
			inError = false
		end)
	end
end

module.pass = function()

	-- battery low check
	if AwesomeWM.values.batteryNotificationSent then goto batteryContinue end
	AwesomeWM.awful.spawn.easy_async_with_shell(AwesomeWM.values.getScript('battery') .. ' charging', function(_stdout, _stderr, _errorReason, _errorCode)
		local value = tonumber(_stdout)
		if value == 1 then return end

		AwesomeWM.awful.spawn.easy_async_with_shell(AwesomeWM.values.getScript('battery') .. ' value', function(_stdout, _stderr, _errorReason, _errorCode)
			local value = tonumber(_stdout)
			if value < AwesomeWM.values.lowBatteryThreshold then
				AwesomeWM.notify.critical('Low battery', 'Battery less than ' .. tostring(AwesomeWM.values.lowBatteryThreshold .. '. Connect your laptop to a charger.'))
				AwesomeWM.values.batteryNotificationSent = true
			else
				AwesomeWM.values.batteryNotificationSent = false
			end

		end)
	end)
	::batteryContinue::

	module.passTimer:again()
end

module.passTimer = AwesomeWM.gears.timer({
	timeout = AwesomeWM.values.passTimeout,
	callback = module.pass
})

module.startup = function()
	local isStartup = tonumber(os.getenv("AWESOME_STARTUP"))
	if isStartup == 0 then
		AwesomeWM.notify.normal("Startup notification", 'Everything is working fine!')
		AwesomeWM.awful.spawn('export AWESOME_STARTUP=1')
	end
end


module.isFile = function(_filePath)
	local f = io.open(_filePath, 'r')

	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

module.restart = function()
	AwesomeWM.awesome.restart()
end

module.spawn = function(_application)
	AwesomeWM.awful.spawn(_application, {tag = AwesomeWM.awful.screen.focused().selected_tag})
end

module.screens = require('functions.screens')
module.clients = require('functions.clients')
module.tags = require('functions.tags')
module.volume = require('functions.volume')
module.brightness = require('functions.brightness')
module.player = require('functions.player')

return module
