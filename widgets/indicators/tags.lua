
local module = {}
local base = require('widgets.indicators.base')

module.height = base.width
module.width = (60 * #(AwesomeWM.values.tags)) + 60
module.margins = base.margins
module.padding = 10
module.timeout = base.timeout
module.opacity = base.opacity

module.layoutIndicator = AwesomeWM.wibox.widget({
	image = '',
	resize = true,
	forced_width = module.height,
	forced_height = module.height,
	widget = AwesomeWM.wibox.widget.imagebox,
})

module.tags = {}

for _, t in pairs(AwesomeWM.values.tags) do
	table.insert(module.tags, AwesomeWM.wibox.widget({
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

module.main = AwesomeWM.wibox.widget({
	{
		module.layoutIndicator,
		margins = module.padding,
		widget = AwesomeWM.wibox.container.margin

	},
	layout = AwesomeWM.wibox.layout.flex.horizontal
})

for _, t in pairs(module.tags) do
	module.main:add(AwesomeWM.wibox.widget({
		t,
		margins = module.padding,
		widget = AwesomeWM.wibox.container.margin
	}))
end


module.box = AwesomeWM.wibox({
	widget = module.main,
	visible = false,
	opacity = module.opacity,
	ontop = true,
	type = 'dock',
	bg = AwesomeWM.beautiful.black,
	height = module.height,
	width = module.width,
	shape = AwesomeWM.gears.shape.rounded_rect,
})

AwesomeWM.awful.placement.bottom(module.box, {margins = module.margins})

module.timer = AwesomeWM.gears.timer({
	timeout = module.timeout,
	callback = function()
		module.box.visible = false
	end
})

module.show = function()
	module.layoutIndicator.image = AwesomeWM.assets.getLayout()
	local selectedTagName = AwesomeWM.awful.screen.focused().selected_tag.name
	for _, t in pairs(module.tags) do
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

	module.box.visible = true
	module.timer:again()
end

return module
