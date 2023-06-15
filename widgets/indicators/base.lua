
local module = {}

module.height = 360
module.width = 60
module.margins = 5
module.timeout = 1
module.opacity = 0.8

module.make = function(_placement, _max_value, _slider_outer_color, _slider_inner_color)
	local indicator = {}

	indicator.icon = AwesomeWM.wibox.widget({
		image = 'icon',
		resize = true,
		widget = AwesomeWM.wibox.widget.imagebox,
	})

	indicator.slider = AwesomeWM.wibox.widget({
		max_value = _max_value,
		background_color = _slider_outer_color,
		color = _slider_inner_color,
		widget = AwesomeWM.wibox.widget.progressbar,
		shape = AwesomeWM.gears.shape.rounded_rect,
		bar_shape = AwesomeWM.gears.shape.rounded_rect,
		margins = 8,
		paddings = 2,
	})

	indicator.value = AwesomeWM.wibox.widget({
		text = 'value',
		align = 'center',
		valign = 'center',
		widget = AwesomeWM.wibox.widget.textbox,
	})

	indicator.main = AwesomeWM.wibox.widget({
		{
			indicator.icon,
			margins = 10,
			widget = AwesomeWM.wibox.container.margin
		},
		{
			indicator.slider,
			direction = 'east',
			layout = AwesomeWM.wibox.container.rotate,
		},
		{
			indicator.value,
			margins = 10,
			widget = AwesomeWM.wibox.container.margin
		},
		layout = AwesomeWM.wibox.layout.align.vertical
	})

	indicator.wibox = AwesomeWM.wibox({
		widget = indicator.main,
		visible = false,
		opacity = module.opacity,
		ontop = true,
		type = 'dock',
		bg = '#111111',
		height = module.height,
		width = module.width,
		shape = AwesomeWM.gears.shape.rounded_rect,
	})

	indicator.timer = AwesomeWM.gears.timer({
		timeout = module.timeout,
		callback = function()
			indicator.wibox.visible = false
		end,
	})

	indicator.wibox.show = function()
		_placement(indicator.wibox, {margins = module.margins})
		indicator.wibox.visible = true
		indicator.timer:again()
	end

	return indicator
end

return module
