local titleComponent = {}

titleComponent.icon = AwesomeWM.wibox.widget({
	image = AwesomeWM.assets.getAsset("icons/archlinux.svg"),
	widget = AwesomeWM.wibox.widget.imagebox,
	resize = true,
})

titleComponent.title = AwesomeWM.wibox.widget({
	markup = "<b>Arch</b> Linux",
	halign = "center",
	font = AwesomeWM.beautiful.pagesFont .. " 30",
	widget = AwesomeWM.wibox.widget.textbox,
})

titleComponent.top = AwesomeWM.wibox.widget({
	{
		titleComponent.icon,
		margins = { left = 40, right = 40, top = 10 },
		widget = AwesomeWM.wibox.container.margin,
	},
	titleComponent.title,
	widget = AwesomeWM.wibox.layout.fixed.horizontal,
})

titleComponent.bottom = AwesomeWM.wibox.widget({
	{

		text = "Dashboard",
		font = AwesomeWM.beautiful.pagesFont .. " 20",
		widget = AwesomeWM.wibox.widget.textbox,
		halign = "center",
	},

	margins = { left = 40 },
	widget = AwesomeWM.wibox.container.margin,
})

titleComponent.main = AwesomeWM.wibox.widget({
	titleComponent.top,
	titleComponent.bottom,
	widget = AwesomeWM.wibox.layout.flex.vertical,
})

return titleComponent
