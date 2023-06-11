-- Notify module

local module = {}

module.normal = function(_title, _text)

	AwesomeWM.naughty.notify({
		preset = AwesomeWM.naughty.config.presets.normal,
		title = _title,
		text = _text,
	})

end

module.low = function(_title, _text)

	AwesomeWM.naughty.notify({
		preset = AwesomeWM.naughty.config.presets.low,
		title = _title,
		text = _text,
	})

end

module.critical = function(_title, _text)

	AwesomeWM.naughty.notify({
		preset = AwesomeWM.naughty.config.presets.critical,
		title = _title,
		text = _text,
	})

end

return module
