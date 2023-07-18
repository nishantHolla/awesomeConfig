
local indicatorTags_sm = {}
local base = require('widgets.indicators.base')

indicatorTags_sm.height = base.width
indicatorTags_sm.width = (60 * #(AwesomeWM.values.tags)) + 60
indicatorTags_sm.margins = base.margins
indicatorTags_sm.padding = 10
indicatorTags_sm.timeout = base.timeout
indicatorTags_sm.opacity = base.opacity

indicatorTags_sm.layoutIndicator = AwesomeWM.wibox.widget({
	image = '',
	resize = true,
	forced_width = indicatorTags_sm.height,
	forced_height = indicatorTags_sm.height,
	widget = AwesomeWM.wibox.widget.imagebox,
})

indicatorTags_sm.tags = {}

for _, t in pairs(AwesomeWM.values.tags) do
	table.insert(indicatorTags_sm.tags, AwesomeWM.wibox.widget({
		{
			text = t.name,
			align = 'center',
			valign = 'center',
			widget = AwesomeWM.wibox.widget.textbox
		},

		shape = AwesomeWM.gears.shape.rounded_rect,
		shape_border_width = 3,
		shape_border_color = AwesomeWM.beautiful.tagIndicatorDead,
		fg = AwesomeWM.beautiful.tagIndicatorDead,
		widget = AwesomeWM.wibox.container.background,
		tagName = t.name

	}))

end

indicatorTags_sm.main = AwesomeWM.wibox.widget({
	{
		indicatorTags_sm.layoutIndicator,
		margins = indicatorTags_sm.padding,
		widget = AwesomeWM.wibox.container.margin

	},
	layout = AwesomeWM.wibox.layout.flex.horizontal
})

for _, t in pairs(indicatorTags_sm.tags) do
	indicatorTags_sm.main:add(AwesomeWM.wibox.widget({
		t,
		margins = indicatorTags_sm.padding,
		widget = AwesomeWM.wibox.container.margin
	}))
end


indicatorTags_sm.box = AwesomeWM.wibox({
	widget = indicatorTags_sm.main,
	visible = false,
	opacity = indicatorTags_sm.opacity,
	ontop = true,
	type = 'dock',
	bg = AwesomeWM.beautiful.black,
	height = indicatorTags_sm.height,
	width = indicatorTags_sm.width,
	shape = AwesomeWM.gears.shape.rounded_rect,
})

AwesomeWM.awful.placement.bottom(indicatorTags_sm.box, {margins = indicatorTags_sm.margins})

indicatorTags_sm.timer = AwesomeWM.gears.timer({
	timeout = indicatorTags_sm.timeout,
	callback = function()
		indicatorTags_sm.box.visible = false
	end
})

indicatorTags_sm.show = function()
	indicatorTags_sm.layoutIndicator.image = AwesomeWM.assets.getLayout()
	local selectedTagName = AwesomeWM.awful.screen.focused().selected_tag.name
	for _, t in pairs(indicatorTags_sm.tags) do
		local colors = AwesomeWM.functions.tags.getColor(t.tagName)
		t.shape_border_color = colors[1]
		t.fg = colors[1]

		-- Folowing code is depricated. Will soon be removed.

		-- local currentTag = AwesomeWM.awful.tag.find_by_name(AwesomeWM.awful.screen.focused(), t.tagName)
		-- local numberOfClients = #(currentTag:clients())
		-- if t.tagName == selectedTagName then
		-- 	t.shape_border_color = AwesomeWM.beautiful.tagIndicatorActive
		-- 	t.fg = AwesomeWM.beautiful.tagIndicatorActive
		-- elseif numberOfClients > 0 then
		-- 	t.shape_border_color = AwesomeWM.beautiful.tagIndicatorAlive
		-- 	t.fg = AwesomeWM.beautiful.tagIndicatorAlive
		-- else
		-- 	t.shape_border_color = AwesomeWM.beautiful.tagIndicatorDead
		-- 	t.fg = AwesomeWM.beautiful.tagIndicatorDead
		-- end
	end

	indicatorTags_sm.box.visible = true
	indicatorTags_sm.timer:again()
end

return indicatorTags_sm
