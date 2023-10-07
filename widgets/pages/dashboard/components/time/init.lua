local timeComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper

timeComponent.time = {}

timeComponent.time.time = AwesomeWM.wibox.widget({
	text = "time",
	align = "center",
	font = AwesomeWM.beautiful.pagesFont .. " 40",
	widget = AwesomeWM.wibox.widget.textbox,
})

timeComponent.time.dayAndDate = AwesomeWM.wibox.widget({
	text = "day",
	align = "center",
	font = AwesomeWM.beautiful.pagesFont .. " 15",
	widget = AwesomeWM.wibox.widget.textbox,
})

timeComponent.time.calendar = AwesomeWM.wibox.widget({
	date = os.date("*t"),
	font = AwesomeWM.beautiful.pagesFont .. " 14",
	spacing = 10,
	fn_embed = function(_widget, _flag, _date)
		local rect = _widget

		if _flag == "header" then
			return AwesomeWM.wibox.widget({})
		elseif _flag == "weekday" then
			rect = AwesomeWM.wibox.widget({
				_widget,
				fg = AwesomeWM.beautiful.blue,
				widget = AwesomeWM.wibox.container.background,
			})
		elseif _flag == "focus" then
			rect = AwesomeWM.wibox.widget({
				_widget,
				fg = AwesomeWM.beautiful.red,
				widget = AwesomeWM.wibox.container.background,
			})
		end

		return rect
	end,
	widget = AwesomeWM.wibox.widget.calendar.month,
})

timeComponent.main = AwesomeWM.wibox.widget({
	timeComponent.time.time,
	timeComponent.time.dayAndDate,
	{
		timeComponent.time.calendar,
		valign = "center",
		align = "center",
		widget = AwesomeWM.wibox.container.place,
	},
	widget = AwesomeWM.wibox.layout.fixed.vertical,
})

timeComponent.refresh = function()
	timeComponent.time.time.text = os.date("%I : %M %p")
	timeComponent.time.dayAndDate.text = os.date("%A %d %B %Y")
end

timeComponent.timer = AwesomeWM.gears.timer({
	timeout = 60,
	callback = function()
		timeComponent.refresh()
		timeComponent.timer:again()
	end,
})

timeComponent.main:connect_signal("button::press", function()
	AwesomeWM.awful.spawn("firefox https://calendar.google.com/")
	AwesomeWM.widgets.pages.dashboard.toggle()
end)

timeComponent.refresh()

return timeComponent
