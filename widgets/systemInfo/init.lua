
local module = {}

module.opacity = 0.7
module.width = 360
module.height = 60
module.padding = 13
module.margins = 5
module.refreshRate = 3

module.batteryIcon = AwesomeWM.wibox.widget({
	image = '',
	resize = true,
	widget = AwesomeWM.wibox.widget.imagebox
})

module.batteryValue = AwesomeWM.wibox.widget({
	text = '',
	align = 'left',
	valign = 'center',
	widget = AwesomeWM.wibox.widget.textbox
})

module.clockIcon = AwesomeWM.wibox.widget({
	image = AwesomeWM.assets.getIcon('timeClockWhite'),
	resize = true,
	widget = AwesomeWM.wibox.widget.imagebox,
})

module.clockValue = AwesomeWM.wibox.widget({
	text = 'hello',
	valign = 'center',
	widget = AwesomeWM.wibox.widget.textbox
})

module.batteryValueBG = AwesomeWM.wibox.widget({
	module.batteryValue,
	fg = AwesomeWM.beautiful.yellowLight,
	widget = AwesomeWM.wibox.container.background,
})

module.clockValueBG = AwesomeWM.wibox.widget({
	module.clockValue,
	fg = AwesomeWM.beautiful.blueLight,
	widget = AwesomeWM.wibox.container.background,
})

module.leftTray = AwesomeWM.wibox.widget({
	module.batteryIcon,
	module.batteryValueBG,
	module.clockIcon,
	module.clockValueBG,
	layout = AwesomeWM.wibox.layout.ratio.horizontal
})

module.leftMain = AwesomeWM.wibox.widget({
	module.leftTray,
	margins = module.padding,
	widget = AwesomeWM.wibox.container.margin
})

module.leftTray:set_ratio(1, 0.25)
module.leftTray:set_ratio(4, 0.55)

module.leftBox = AwesomeWM.wibox({
	widget = module.leftMain,
	visible = false,
	opacity = module.opacity,
	ontop = true,
	type =  'dock',
	width = module.width,
	height = module.height,
	shape = AwesomeWM.gears.shape.rounded_rect
})

module.rightMain = AwesomeWM.wibox.widget({
	{
		widget = AwesomeWM.wibox.widget.systray,
	},
	margins = module.padding,
	widget = AwesomeWM.wibox.container.margin
})


module.rightBox = AwesomeWM.wibox({
	widget = module.rightMain,
	visible = false,
	opacity = module.opacity,
	ontop = true,
	type = 'dock',
	width = module.width,
	height = module.height,
	shape = AwesomeWM.gears.shape.rounded_rect
})

AwesomeWM.awful.placement.bottom_left(module.leftBox, {margins = module.margins})
AwesomeWM.awful.placement.bottom_right(module.rightBox, {margins = module.margins})


module.refresh = function()

	local date = os.date('*t')
	local hour = ''
	local endString = 'AM'
	if date.hour > 12 then
		hour = tostring(date.hour - 12)
		endString = 'PM'
	else
		hour = tostring(date.hour)
	end
	local time = (tostring(date.day) .. '/' .. tostring(date.month) .. '/' .. tostring(date.year) .. ' | ' .. hour .. ':' .. tostring(date.min) .. ' ' .. endString)
	module.clockValue.text = time

	AwesomeWM.awful.spawn.easy_async_with_shell(AwesomeWM.values.getScript('battery') .. ' charging', function(_stdout, _stderr, _errorReason, _errorCode)
		local charging = false
		local icon = ''
		local value = tonumber(_stdout)
		if value == 1 then charging = true end

		AwesomeWM.awful.spawn.easy_async_with_shell(AwesomeWM.values.getScript('battery') .. ' value', function(_stdout, _stderr, _errorReason, _errorCode)
			local value = tonumber(_stdout)
			
			if charging then
				module.batteryValueBG.fg = AwesomeWM.beautiful.greenLight
				icon = AwesomeWM.assets.getIcon('batteryChargingWhite')
			elseif value > 95 then
				module.batteryValueBG.fg = AwesomeWM.beautiful.greenLight
				icon = AwesomeWM.assets.getIcon('batteryFullWhite')
			elseif value > 75 then
				module.batteryValueBG.fg = AwesomeWM.beautiful.greenLight
				icon = AwesomeWM.assets.getIcon('batteryHighWhite')
			elseif value > 25 then
				module.batteryValueBG.fg = AwesomeWM.beautiful.yellowLight
				icon = AwesomeWM.assets.getIcon('batteryMediumWhite')
			else
				module.batteryValueBG.fg = AwesomeWM.beautiful.redLight
				icon = AwesomeWM.assets.getIcon('batteryLowWhite')
			end

			if value < AwesomeWM.values.lowBatteryThreshold then
				AwesomeWM.functions.lowBattery()
			end

			module.batteryIcon.image = icon
			module.batteryValue.text = tostring(value) .. '%'

		end)


	end)


end

module.timer = AwesomeWM.gears.timer({
	timeout = module.refreshRate,
	callback = function()
		if module.leftBox.visible == true then
			module.refresh()
			return true
		end

		return false
	end
})

module.toggle = function()

	module.refresh()
	module.leftBox.visible = not module.leftBox.visible
	module.rightBox.visible = not module.rightBox.visible
	module.timer:again()

end

return module
