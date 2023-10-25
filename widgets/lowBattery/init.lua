local lowBattery_sm = {}

lowBattery_sm.icon = AwesomeWM.wibox.widget({
	image = AwesomeWM.assets.getIcon("batteryLowWhite"),
	resize = true,
	forced_height = 100,
	forced_width = 100,
	widget = AwesomeWM.wibox.widget.imagebox,
})

lowBattery_sm.text = AwesomeWM.wibox.widget({
	text = "___",
	font = AwesomeWM.beautiful.pagesFont .. " 30",
	widget = AwesomeWM.wibox.widget.textbox,
})

lowBattery_sm.closeButton = AwesomeWM.wibox.widget({
	text = "Close",
	font = AwesomeWM.beautiful.pagesFont .. " 20",
	valign = "center",
	align = "center",
	widget = AwesomeWM.wibox.widget.textbox,
})

lowBattery_sm.main = AwesomeWM.wibox.widget({
	{
		lowBattery_sm.icon,
		align = "center",
		widget = AwesomeWM.wibox.container.place,
	},

	{
		lowBattery_sm.text,
		fg = AwesomeWM.beautiful.white,
		widget = AwesomeWM.wibox.container.background,
	},
	{
		lowBattery_sm.closeButton,
		fg = AwesomeWM.beautiful.white,
		bg = AwesomeWM.beautiful.red,
		widget = AwesomeWM.wibox.container.background,
	},
	spacing = 20,
	layout = AwesomeWM.wibox.layout.flex.vertical,
})

lowBattery_sm.wibox = AwesomeWM.wibox({
	widget = AwesomeWM.wibox.widget({
		lowBattery_sm.main,
		align = "center",
		valign = "center",
		widget = AwesomeWM.wibox.container.place,
	}),
	visible = false,
	opacity = 0.85,
	ontop = true,
	type = "dock",
	bg = AwesomeWM.beautiful.gray,
	height = AwesomeWM.values.screenHeight,
	width = AwesomeWM.values.screenWidth,
	input_passthrough = false,
})

lowBattery_sm.closeButton:connect_signal("button::press", function()
	lowBattery_sm.hide()
end)

AwesomeWM.awful.placement.centered(lowBattery_sm.wibox)

lowBattery_sm.show = function(_batteryValue)
	AwesomeWM.functions.brightness.findBrightnessAnd(function(_icon, _value)
		lowBattery_sm.text.text = "Battery level less than " .. tostring(_batteryValue) .. "%. Connect me to a charger!"
		lowBattery_sm.brightnessValue = _value
		AwesomeWM.functions.brightness.set(15)
		lowBattery_sm.wibox.visible = true
	end)
end

lowBattery_sm.hide = function()
	if not lowBattery_sm.brightnessValue then
		return
	end
	AwesomeWM.functions.brightness.set(lowBattery_sm.brightnessValue)
	lowBattery_sm.wibox.visible = false
end

return lowBattery_sm
