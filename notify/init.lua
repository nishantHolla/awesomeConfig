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

notify_m.initNotifications = function() end

return notify_m
