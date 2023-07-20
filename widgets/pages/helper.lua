
local helper_sm = {}
local values_sm = AwesomeWM.widgets.pages.values

helper_sm.makeComponent = function(_options)
	_options = _options or {}
	_options.widget = _options.widget or AwesomeWM.wibox.widget()
	_options.heading = _options.heading or 'Heading not found'
	_options.overrides = _options.overrides or {}
	_options.values = AwesomeWM.functions.table.shallowCopy(values_sm)

	for property, value in pairs(_options.overrides) do
		_options.values[property] = value
	end

	local component = {}
	local font = _options.values.headingFont .. ' ' .. _options.values.headingFontSize

	component.heading = AwesomeWM.wibox.widget({
		markup = _options.heading,
		valign = 'center',
		align = 'center',
		font = font,
		widget = AwesomeWM.wibox.widget.textbox
	})

	component.headingBackground = AwesomeWM.wibox.widget({
		component.heading,
		fg = _options.values.inactiveContainerFg,
		widget = AwesomeWM.wibox.container.background
	})

	component.layout = AwesomeWM.wibox.widget({
		component.headingBackground,
		_options.widget,
		widget = AwesomeWM.wibox.layout.ratio.vertical
	})

	component.layout:set_ratio(2, _options.values.contentRatio or 0.9)

	component.mainBackground = AwesomeWM.wibox.widget({
		component.layout,
		bg = _options.values.inactiveContainerBg,
		widget = AwesomeWM.wibox.container.background
	})

	component.main = AwesomeWM.wibox.widget({
		component.mainBackground,
		margins = 5,
		widget = AwesomeWM.wibox.container.margin
	})

	component.main:connect_signal('mouse::enter', function()
		component.mainBackground.bg = _options.values.activeContainerBg
		component.headingBackground.fg = _options.values.activeContainerFg
		component.heading.markup = '<b>' .. _options.heading .. '</b>'
	end)

	component.main:connect_signal('mouse::leave', function()
		component.mainBackground.bg = _options.values.inactiveContainerBg
		component.headingBackground.fg = _options.values.inactiveContainerFg
		component.heading.markup =  _options.heading
	end)

	return component
end

helper_sm.makeButtion = function(_options)
	_options = _options or {}
	_options.onClick = _options.onClick or function()end
	_options.widget = _options.widget or AwesomeWM.wibox.widget()
	_options.overrides = _options.overrides or {}
	_options.values = AwesomeWM.functions.table.shallowCopy(values_sm)

	for property, value in pairs(_options.overrides) do
		_options.values[property] = value
	end

	local button = {}

	button.background = AwesomeWM.wibox.widget({
		bg = _options.values.inactiveButtonBg,
		fg = _options.values.inactiveButtonFg,
		widget = AwesomeWM.wibox.container.background,
		shape = function(c, w, h)
			AwesomeWM.gears.shape.circle(c, w, h)
		end,
		shape_border_width = _options.values.buttonBorderWidth,
		shape_border_color = _options.values.inactiveButtonBorderColor,
	})

	button.main = AwesomeWM.wibox.widget({
		{
			_options.widget,
			margins = _options.values.padding or 15,
			widget = AwesomeWM.wibox.container.margin
		},
		widget = button.background,
	})

	button.main:connect_signal('mouse::enter', function()
		button.main.bg = _options.values.activeButtonBg
		button.main.fg = _options.values.activeButtonFg
		button.main.shape_border_color = _options.values.activeButtonBorderColor
	end)

	button.main:connect_signal('mouse::leave', function()
		button.main.bg = _options.values.inactiveButtonBg
		button.main.fg = _options.values.inactiveButtonFg
		button.main.shape_border_color = _options.values.inactiveButtonBorderColor
	end)

	button.main:connect_signal('button::press', _options.onClick)

	return button
end

return helper_sm
