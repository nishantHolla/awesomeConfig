local systemTrayComponent = {}

systemTrayComponent.main = AwesomeWM.wibox.widget({
	AwesomeWM.wibox.widget.systray(),
	margins = 10,
	widget = AwesomeWM.wibox.container.margin,
})

return systemTrayComponent
