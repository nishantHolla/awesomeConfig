
local battery_sm = {}


battery_sm.findBatteryAnd = function(_function)
	if type(_function) ~= "function" then return end

	AwesomeWM.awful.spawn.easy_async(AwesomeWM.values.getScript('battery') .. ' value', function(_stdout, _stdError, _errorReason, _errorCode)
		local chargingIndicator = _stdout:sub(-2)
		local text  = _stdout:sub(1, -3)
		local value = tonumber(text)
		local icon = ''

		if chargingIndicator == "C\n" then
			icon = 'batteryChargingWhite'
		elseif value > 95 then
			icon = 'batteryFullWhite'
		elseif value > 70 then
			icon = 'batteryHighWhite'
		elseif value > 30 then
			icon = 'batteryMediumWhite'
		else
			icon = 'batteryLowWhite'
		end

		icon = AwesomeWM.assets.getIcon(icon)
		_function(icon, value)

	end)

end

battery_sm.checkBattery = function()
	battery_sm.findBatteryAnd(function(icon, value)
		if value < AwesomeWM.values.batteryLowThreshold then
			if AwesomeWM.values.batteryLowNotified == false then
				if icon ~= AwesomeWM.assets.getIcon('batteryChargingWhite') then
					AwesomeWM.notify.critical('Battery level less than ' .. tostring(AwesomeWM.values.batteryLowThreshold) .. '%. Connect me to a charger!')
					AwesomeWM.values.batteryLowNotified = true
					AwesomeWM.functions.brightness.set(10)
				end
			end
		else
			AwesomeWM.values.batteryLowNotified = false
		end
	end)


	battery_sm.timer:again()
end

battery_sm.timer = AwesomeWM.gears.timer({
	timeout = 3,
	callback = battery_sm.checkBattery
})

return battery_sm
