local notify_m = {}

notify_m.normal = function(_title, _text)
	AwesomeWM.naughty.notify({
		preset = AwesomeWM.naughty.config.presets.normal,
		title = _title,
		text = _text,
	})
end

notify_m.low = function(_title, _text)
	AwesomeWM.naughty.notify({
		preset = AwesomeWM.naughty.config.presets.low,
		title = _title,
		text = _text,
	})
end

notify_m.critical = function(_title, _text)
	AwesomeWM.naughty.notify({
		preset = AwesomeWM.naughty.config.presets.critical,
		title = _title,
		text = _text,
	})
end

notify_m.initNotifications = function()
	AwesomeWM.naughty.connect_signal("added", function(_notification)
		local notificationFile = io.open(AwesomeWM.values.notificationHistoryFile, "a")
		local section = "--------------------------------------\n"
		if notificationFile then
			notificationFile:write(
				string.format(
					"Title: %s\nMessage: %s\nTime: %s\n%s",
					_notification.title,
					_notification.text,
					os.date("%Y-%m-%d %H:%M:%S"),
					section
				)
			)
			notificationFile:close()
		end
	end)
end

return notify_m
