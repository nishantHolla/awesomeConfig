local battery_sm = {}

battery_sm.findBatteryAnd = function(_function)
	if type(_function) ~= "function" then
		return
	end

	AwesomeWM.awful.spawn.easy_async(
		AwesomeWM.values.getScript("battery") .. " value",
		function(_stdout, _stdError, _errorReason, _errorCode)
			local chargingIndicator = _stdout:sub(-2)
			local text = _stdout:sub(1, -3)
			local value = tonumber(text)
			local icon = ""

			if chargingIndicator == "C\n" then
				icon = "batteryChargingWhite"
			elseif value > 95 then
				icon = "batteryFullWhite"
			elseif value > 70 then
				icon = "batteryHighWhite"
			elseif value > 30 then
				icon = "batteryMediumWhite"
			else
				icon = "batteryLowWhite"
			end

			icon = AwesomeWM.assets.getIcon(icon)
			_function(icon, value)
		end
	)
end

battery_sm.checkBattery = function()
	battery_sm.findBatteryAnd(function(icon, value)
		AwesomeWM.widgets.pages.dashboard.components.stats.batteryStat.silentRefresh(icon, value)

		if icon == AwesomeWM.assets.getIcon("batteryChargingWhite") then
			return
		end

		for _, tier in pairs(AwesomeWM.values.batteryLowThresholds) do
			if not tier.notified and value <= tier.level then
				tier.notified = true
				AwesomeWM.widgets.lowBattery.show(value)
				return
			end
		end

		-- if value < AwesomeWM.values.batteryLowThreshold then
		-- 	if AwesomeWM.values.batteryLowNotified == false then
		-- 		if icon ~= AwesomeWM.assets.getIcon("batteryChargingWhite") then
		-- 			AwesomeWM.widgets.lowBattery.show()
		-- 			AwesomeWM.values.batteryLowNotified = true
		-- 		end
		-- 	end
		-- elseif AwesomeWM.values.batteryLowNotified then
		-- 	AwesomeWM.naughty.destroy(AwesomeWM.values.lowBatteryNotification, "Charged")
		-- 	AwesomeWM.values.batteryLowNotified = false
		-- end
	end)

	battery_sm.timer:again()
end

battery_sm.timer = AwesomeWM.gears.timer({
	timeout = 60,
	callback = battery_sm.checkBattery,
})

return battery_sm
