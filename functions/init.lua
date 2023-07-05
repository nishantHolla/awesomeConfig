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
	AwesomeWM.awful.spawn.easy_async_with_shell(AwesomeWM.values.getScript('battery') .. ' charging',
		function(_stdout, _stderr, _errorReason, _errorCode)
			local value = tonumber(_stdout)
			if value == 1 then return end

			AwesomeWM.awful.spawn.easy_async_with_shell(AwesomeWM.values.getScript('battery') .. ' value',
				function(_stdout, _stderr, _errorReason, _errorCode)
					local value = tonumber(_stdout)
					if value < AwesomeWM.values.lowBatteryThreshold then
						AwesomeWM.notify.critical('Low battery',
							'Battery less than ' ..
							tostring(AwesomeWM.values.lowBatteryThreshold .. '. Connect your laptop to a charger.'))
						AwesomeWM.values.batteryNotificationSent = true
					elseif AwesomeWM.values.batteryNotificationSent then
						AwesomeWM.notify.normal('Low battery',
							'Battery more than ' .. tostring(AwesomeWM.values.lowBatteryThreshold .. '.'))
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



module.spawn = function(_application, _options)

	if _options then
		if _options.tag == nil then
			_options.tag = AwesomeWM.awful.screen.focused().selected_tag
		end
	else
		_options = {tag = AwesomeWM.awful.screen.focused().selected_tag}
	end

	AwesomeWM.awful.spawn(_application, _options)
end

module.screens = require('functions.screens')
module.clients = require('functions.clients')
module.tags = require('functions.tags')
module.volume = require('functions.volume')
module.brightness = require('functions.brightness')
module.player = require('functions.player')

return module
