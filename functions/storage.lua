
local storage_sm = {}

storage_sm.get = function()
	return AwesomeWM.values.getScript('storage')
end

storage_sm.findStorageAnd = function(_function)
	if type(_function) ~= "function" then return end

	AwesomeWM.awful.spawn.easy_async(storage_sm.get(), function(_stdout, _stderr, _errorReason, _exitCode)
		local storage = tonumber(_stdout)
		local icon = AwesomeWM.assets.getIcon('hardDriveWhite')

		_function(icon, storage)
	end)
end


return storage_sm
