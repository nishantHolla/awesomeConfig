
local weatherComponent = {}

weatherComponent.makeDataLabel = function(_text, _color, _size, _align)
	_color = _color or AwesomeWM.beautiful.white
	_size = _size or 20
	_align = _align or 'center'
	return AwesomeWM.wibox.widget({
		markup = _text,
		align = _align,
		valign = 'center',
		leftMarkup = '<span foreground="' .. _color .. '">',
		rightMarkup = '</span>',
		font = AwesomeWM.beautiful.pagesFont .. ' ' .. tostring(_size),
		widget = AwesomeWM.wibox.widget.textbox
	})
end

weatherComponent.icon = weatherComponent.makeDataLabel('icon', AwesomeWM.beautiful.white, 100)
weatherComponent.location = weatherComponent.makeDataLabel('location', AwesomeWM.beautiful.green, 30)
weatherComponent.condition = weatherComponent.makeDataLabel('condition', AwesomeWM.beautiful.orange, 20)
weatherComponent.humidity = weatherComponent.makeDataLabel('humidity', AwesomeWM.beautiful.yellow, 20, 'left')
weatherComponent.temperature = weatherComponent.makeDataLabel('temperature', AwesomeWM.beautiful.red, 20, 'left')
weatherComponent.windSpeed = weatherComponent.makeDataLabel('temperature', AwesomeWM.beautiful.blue, 20, 'left')

weatherComponent.data = AwesomeWM.wibox.widget({
	weatherComponent.makeDataLabel('Humidity', nil, nil, 'right'),
	weatherComponent.humidity,
	weatherComponent.makeDataLabel('Temperature', nil, nil, 'right'),
	weatherComponent.temperature,
	weatherComponent.makeDataLabel('Wind Speed', nil, nil, 'right'),
	weatherComponent.windSpeed,
	spacing = 10,
	forced_num_cols = 2,
	expand = true,
	widget = AwesomeWM.wibox.layout.grid.vertical
})

weatherComponent.dataList = {
	weatherComponent.icon,
	weatherComponent.location,
	weatherComponent.condition,
	weatherComponent.humidity,
	weatherComponent.temperature,
	weatherComponent.windSpeed
}

weatherComponent.refresh = function()

	AwesomeWM.awful.spawn.easy_async('curl "wttr.in/?format=%c\\n%l\\n%C\\n%h\\n%t\\n%w"', function(_stdout, _stderr, _errorReason, _errorCode)
		local lines = {}
		for s in _stdout:gmatch("[^\r\n]+") do
			table.insert(lines, s)
		end

		if #lines ~= 6 then
			return
		end

		lines[1] = lines[1]:sub(1, -2)
		local counter = 1
		for _, data in pairs(weatherComponent.dataList) do
			data.markup = data.leftMarkup .. lines[counter] .. data.rightMarkup
			counter = counter + 1
		end
	end)

end

weatherComponent.layout = AwesomeWM.wibox.widget({
	weatherComponent.icon,
	weatherComponent.location,
	weatherComponent.condition,
	weatherComponent.data,
	widget = AwesomeWM.wibox.layout.fixed.vertical
})

weatherComponent.main = AwesomeWM.wibox.widget({
	weatherComponent.layout,
	margins = 10,
	widget = AwesomeWM.wibox.container.margin
})

return weatherComponent
