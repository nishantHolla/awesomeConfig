local minimizedBar_sm = {}

minimizedBar_sm.width = AwesomeWM.values.screenWidth - 200
minimizedBar_sm.height = 30
minimizedBar_sm.opacity = 0.5
minimizedBar_sm.tileHeight = 30

minimizedBar_sm.layout = AwesomeWM.wibox.widget({
	layout = AwesomeWM.wibox.layout.fixed.horizontal,
})

minimizedBar_sm.wibox = AwesomeWM.wibox({
	widget = minimizedBar_sm.layout,
	visible = true,
	opacity = minimizedBar_sm.opacity,
	ontop = true,
	type = "desktop",
	bg = "#000000",
	height = minimizedBar_sm.height,
	width = minimizedBar_sm.width,
})

minimizedBar_sm.makeClientTile = function(client)
	local tile = AwesomeWM.wibox.widget({
		{

			text = client.class,
			widget = AwesomeWM.wibox.widget.textbox,
		},
		left = 5,
		right = 5,
		top = 2,
		bottom = 2,
		widget = AwesomeWM.wibox.container.margin,
		client = client,
	})

	tile:connect_signal("button::press", function()
		client.minimized = false
		minimizedBar_sm.refresh()
	end)

	return tile
end
minimizedBar_sm.refresh = function()
	minimizedBar_sm.layout:reset()
	local counter = 0
	for _, c in ipairs(AwesomeWM.client.get()) do
		if c.minimized == true then
			counter = counter + 1
			minimizedBar_sm.layout:add(minimizedBar_sm.makeClientTile(c))
		end
	end

	if counter == 0 then
		minimizedBar_sm.wibox.visible = false
	else
		minimizedBar_sm.wibox.visible = true
	end
end

AwesomeWM.awful.placement.bottom_right(minimizedBar_sm.wibox, { margins = 0 })
minimizedBar_sm.refresh()

return minimizedBar_sm
