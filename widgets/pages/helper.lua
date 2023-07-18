
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
		{
			text = _options.heading,
			valign = 'center',
			align = 'center',
			font = font,
			widget = AwesomeWM.wibox.widget.textbox
		},
		fg = _options.values.inactiveContainerFg,
		widget = AwesomeWM.wibox.container.background
	})

	component.layout = AwesomeWM.wibox.widget({
		component.heading,
		_options.widget,
		widget = AwesomeWM.wibox.layout.ratio.vertical
	})

	component.layout:set_ratio(2, _options.values.contentRatio or 0.90)

	component.main = AwesomeWM.wibox.widget({
		component.layout,
		bg = _options.values.inactiveContainerBg,
		widget = AwesomeWM.wibox.container.background
	})

	component.main:connect_signal('mouse::enter', function()
		component.main.bg = _options.values.activeContainerBg
		component.heading.fg = _options.values.activeContainerFg
	end)

	component.main:connect_signal('mouse::leave', function()
		component.main.bg = _options.values.inactiveContainerBg
		component.heading.fg = _options.values.inactiveContainerFg
	end)

	return component
end

return helper_sm
