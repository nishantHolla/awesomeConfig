
local module = {}

module.height = 60
module.width = 360
module.margins = 5
module.padding = 5
module.timeout = 1
module.opacity = 0.8
module.timeFormat = '%a %d %B %I:%M %p'

module.left = {}
module.right = {}

module.left.clockIcon = AwesomeWM.wibox.widget({
	image = AwesomeWM.assets.getIcon('timeClockWhite'),
	widget = AwesomeWM.wibox.widget.imagebox,
	resize = true
})

module.left.batteryIcon = AwesomeWM.wibox.widget({
	widget = AwesomeWM.wibox.widget.imagebox,
	resize = true
})

module.left.timeText = AwesomeWM.wibox.widget({
	align = 'center',
	valign = 'center',
	text = "time",
	widget = AwesomeWM.wibox.widget.textbox,
})

module.left.batteryText = AwesomeWM.wibox.widget({
	align = 'left',
	valign = 'center',
	text = "99%",
	widget = AwesomeWM.wibox.widget.textbox
})

module.left.ratio = AwesomeWM.wibox.widget({
	{
		module.left.batteryIcon,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin,
	},
	module.left.batteryText,
	{
		module.left.clockIcon,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin,
	},
	{
		module.left.timeText,
		widget = AwesomeWM.wibox.container.background,
		fg = AwesomeWM.beautiful.blueLight,
	},
	layout = AwesomeWM.wibox.layout.ratio.horizontal,
})

module.left.ratio:set_ratio(4, 0.6)

module.left.main = AwesomeWM.wibox.widget({
	module.left.ratio,
	widget = AwesomeWM.wibox.container.margin,
	margins = module.padding
})


module.left.wibox = AwesomeWM.wibox({
	widget = module.left.main,
	visible = true,
	opacity = module.opacity,
	ontop = false,
	type = 'dock',
	bg = "#111111",
	height = module.height,
	width = module.width,
	shape = AwesomeWM.gears.shape.rounded_rect,
})

module.right.systray = AwesomeWM.wibox.widget({
	widget = AwesomeWM.wibox.widget.systray,
	opacity = module.opacity
})

module.right.main = AwesomeWM.wibox.widget({
	module.right.systray,
	widget = AwesomeWM.wibox.container.margin,
	margins = module.padding

})

module.right.wibox = AwesomeWM.wibox({
	widget = module.right.main,
	visible = true,
	opacity = module.opacity,
	ontop = false,
	type = 'dock',
	bg = "#111111",
	height = module.height,
	width = module.width,
	shape = AwesomeWM.gears.shape.rounded_rect,
})


module.refresh = function()
	module.left.timeText.text = os.date(module.timeFormat)

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

		if value < AwesomeWM.values.batteryLowThreshold then
			if AwesomeWM.values.batteryLowNotified == false then
				AwesomeWM.notify.critical('Battery level less than ' .. tostring(AwesomeWM.values.batteryLowThreshold) .. '%. Connect me to a charger!')
				AwesomeWM.values.batteryLowNotified = true
			end
		else
			AwesomeWM.values.batteryLowNotified = false
		end
		module.left.batteryText.text = text .. "%"
		module.left.batteryIcon.image = AwesomeWM.assets.getIcon(icon)
	end)
end

module.timer = AwesomeWM.gears.timer({
	timeout = module.timeout,
	callback = function()
		module.refresh()
		module.timer:again()
	end
})

module.timer:start()
AwesomeWM.awful.placement.bottom_left(module.left.wibox, {margins=module.margins})
AwesomeWM.awful.placement.bottom_right(module.right.wibox, {margins=module.margins})


return module
