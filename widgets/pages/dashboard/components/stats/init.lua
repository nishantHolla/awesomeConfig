
local statsComponent = {}


local makeStat = function(_options)
	_options = _options or {}
	_options.maxValue = _options.maxValue or 100
	_options.value = _options.value or 10
	_options.paddings = _options.paddings or 5
	_options.fgColor = _options.fgColor or AwesomeWM.beautiful.black
	_options.bgColor = _options.bgColor or AwesomeWM.beautiful.white
	_options.shape = function(c, w, h)
		AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
	end
	_options.barShape = function(c, w, h)
		AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
	end

	local stat = {}

	stat.icon = AwesomeWM.wibox.widget({
		image = '',
		resize = true,
		widget = AwesomeWM.wibox.widget.imagebox
	})

	stat.indicator = AwesomeWM.wibox.widget({
		text = tostring(_options.value) .. '%',
		valign = 'center',
		align = 'center',
		widget = AwesomeWM.wibox.widget.textbox
	})

	stat.bar = AwesomeWM.wibox.widget({
		value = _options.value,
		max_value = 100,
		shape = _options.shape,
		bar_shape = _options.barShape,
		color = _options.fgColor,
		background_color = _options.bgColor,
		paddings = _options.paddings,
		widget = AwesomeWM.wibox.widget.progressbar
	})

	stat.main = AwesomeWM.wibox.widget({
		{
			stat.icon,
			valign = 'center',
			align = 'center',
			widget = AwesomeWM.wibox.container.place
		},
		stat.indicator,
		{
			stat.bar,
			left = 0,
			right = 10,
			top = 37,
			bottom = 37,
			widget = AwesomeWM.wibox.container.margin
		},
		widget = AwesomeWM.wibox.layout.ratio.horizontal
	})

	stat.main:ajust_ratio(2, 0.1, 0.2, 0.7)

	if _options.refresh then
		stat.silentRefresh = function(_icon, _value)
			_value = math.floor((_value * 100) / _options.maxValue)
			stat.icon.image = _icon
			stat.indicator.text = _value .. '%'
			stat.bar.value = _value
		end

		stat.refresh = function()
			_options.refresh(stat.silentRefresh)
		end
	end

	return stat
end

statsComponent.volumeStat = makeStat({
	refresh = AwesomeWM.functions.volume.findVolumeAnd,
	bgColor = AwesomeWM.beautiful.redLight,
	fgColor = AwesomeWM.beautiful.redDark
})

statsComponent.brightnessStat = makeStat({
	maxValue = 255,
	refresh = AwesomeWM.functions.brightness.findBrightnessAnd,
	bgColor = AwesomeWM.beautiful.blueLight,
	fgColor = AwesomeWM.beautiful.blueDark
})

statsComponent.storageStat = makeStat({
	refresh = AwesomeWM.functions.storage.findStorageAnd,
	bgColor = AwesomeWM.beautiful.yellowLight,
	fgColor = AwesomeWM.beautiful.yellowDark
})

statsComponent.batteryStat = makeStat({
	refresh = AwesomeWM.functions.battery.findBatteryAnd,
	bgColor = AwesomeWM.beautiful.greenLight,
	fgColor = AwesomeWM.beautiful.greenDark
})

statsComponent.main = AwesomeWM.wibox.widget({
	{
		statsComponent.volumeStat.main,
		statsComponent.brightnessStat.main,
		statsComponent.storageStat.main,
		statsComponent.batteryStat.main,
		widget = AwesomeWM.wibox.layout.flex.vertical
	},
	left = 20,
	right = 20,
	widget = AwesomeWM.wibox.container.margin
})

statsComponent.refresh = function()
	statsComponent.volumeStat.refresh()
	statsComponent.brightnessStat.refresh()
	statsComponent.storageStat.refresh()
	statsComponent.batteryStat.refresh()
end


return statsComponent
