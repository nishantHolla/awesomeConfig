local time_sm = {}

time_sm.width = 80
time_sm.height = 15
time_sm.opacity = 0.5

time_sm.main = AwesomeWM.wibox.widget({
	align = "center",
	valign = "center",
	format = "%I : %M %p",
	font = "SometypeMono NFM 10",
	widget = AwesomeWM.wibox.widget.textclock,
})

time_sm.wibox = AwesomeWM.wibox({
	widget = time_sm.main,
	visible = true,
	opacity = time_sm.opacity,
	ontop = true,
	type = "desktop",
	bg = "#000000",
	height = time_sm.height,
	width = time_sm.width,
})

AwesomeWM.awful.placement.top_right(time_sm.wibox, { margins = 0 })
return time_sm
