
local indicatorBase_sm = {}

indicatorBase_sm.height = 360
indicatorBase_sm.width = 60
indicatorBase_sm.margins = 5
indicatorBase_sm.timeout = 1
indicatorBase_sm.opacity = 0.8

indicatorBase_sm.shape = function(c, w, h)
	AwesomeWM.gears.shape.rounded_rect(c, w, h, 100)
end

indicatorBase_sm.make = function(_placement, _max_value, _slider_outer_color, _slider_inner_color)
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
		shape = indicatorBase_sm.shape,
		bar_shape = indicatorBase_sm.shape,
		margins = 8,
		paddings = 5,
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
		opacity = indicatorBase_sm.opacity,
		ontop = true,
		type = 'dock',
		bg = '#111111',
		height = indicatorBase_sm.height,
		width = indicatorBase_sm.width,
		shape = AwesomeWM.gears.shape.rounded_rect,
	})

	indicator.timer = AwesomeWM.gears.timer({
		timeout = indicatorBase_sm.timeout,
		callback = function()
			indicator.wibox.visible = false
		end,
	})

	indicator.wibox.show = function()
		_placement(indicator.wibox, {margins = indicatorBase_sm.margins})
		indicator.wibox.visible = true
		indicator.timer:again()
	end

	return indicator
end

return indicatorBase_sm
