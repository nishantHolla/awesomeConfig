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

module.shutdown = function()
	if AwesomeWM.user then AwesomeWM.user.exit() end
	AwesomeWM.awful.spawn.with_shell('shutdown now')
end

module.screens = require('functions.screens')
module.clients = require('functions.clients')
module.tags = require('functions.tags')
module.volume = require('functions.volume')
module.brightness = require('functions.brightness')
module.player = require('functions.player')



return module
