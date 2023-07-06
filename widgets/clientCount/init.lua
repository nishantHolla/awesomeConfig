
local module = {}

module.width = 35
module.height = 15
module.opacity = 0.5

module.main = AwesomeWM.wibox.widget({
	text = '0',
	align = 'center',
	valign = 'center',
	font = 'Quicksand 10',
	widget = AwesomeWM.wibox.widget.textbox
})

module.wibox = AwesomeWM.wibox({
	widget = module.main,
	visible = true,
	opacity = module.opacity,
	ontop = true,
	type = 'desktop',
	bg = '#000000',
	height = module.height,
	width = module.width,
})


AwesomeWM.awful.placement.top_left(module.wibox, {margins = 0})
return module
