
local functions_m = {}

functions_m.initErrorHandling = function()
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

functions_m.isFile = function(_filePath)
	local f = io.open(_filePath, 'r')

	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

functions_m.restart = function()
	AwesomeWM.awesome.restart()
end



functions_m.spawn = function(_application, _options)

	if _options then
		if _options.tag == nil then
			_options.tag = AwesomeWM.awful.screen.focused().selected_tag
		end
	else
		_options = {tag = AwesomeWM.awful.screen.focused().selected_tag}
	end

	AwesomeWM.awful.spawn(_application, _options)
end

functions_m.shutdown = function()
	if AwesomeWM.user then AwesomeWM.user.exit() end
	AwesomeWM.awful.spawn.with_shell('shutdown now')
end

functions_m.screens = require('functions.screens')
functions_m.clients = require('functions.clients')
functions_m.tags = require('functions.tags')
functions_m.volume = require('functions.volume')
functions_m.brightness = require('functions.brightness')
functions_m.player = require('functions.player')
functions_m.table = require('functions.table')
functions_m.storage = require('functions.storage')
functions_m.battery = require('functions.battery')

functions_m.battery.timer:start()

return functions_m
