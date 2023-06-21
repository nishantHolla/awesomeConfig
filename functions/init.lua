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


module.isFile = function(_filePath)
	local f = io.open(_filePath, 'r')

	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

module.lowBattery = function()
	AwesomeWM.notify.critical('Low battery', 'Battery less than ' .. tostring(AwesomeWM.values.lowBatteryThreshold .. '. Connect your laptop to a charger.'))
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
