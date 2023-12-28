local clientProperties_sm = {}

clientProperties_sm.width = 200
clientProperties_sm.height = 30
clientProperties_sm.opacity = 0.5

clientProperties_sm.main = AwesomeWM.wibox.widget({
	text = "0",
	align = "center",
	valign = "center",
	font = AwesomeWM.beautiful.defaultFont .. " 10",
	widget = AwesomeWM.wibox.widget.textbox,
})

clientProperties_sm.layout = AwesomeWM.wibox.widget({
	clientProperties_sm.main,
	layout = AwesomeWM.wibox.layout.fixed.horizontal,
})

clientProperties_sm.wibox = AwesomeWM.wibox({
	widget = clientProperties_sm.layout,
	visible = true,
	opacity = clientProperties_sm.opacity,
	ontop = true,
	type = "desktop",
	bg = "#000000",
	height = clientProperties_sm.height,
	width = clientProperties_sm.width,
})

clientProperties_sm.refresh = function(client)
	client = client or AwesomeWM.client.focus
	if not client then
		clientProperties_sm.wibox.visible = false
		clientProperties_sm.main.text = ""
		return
	end

	local propertyCount = 0
	local clientProperties = ""

	if client.notToKill then
		clientProperties = clientProperties .. " N |"
		propertyCount = propertyCount + 1
	end

	if client.fullscreen then
		clientProperties = clientProperties .. " F |"
		propertyCount = propertyCount + 1
	end

	if client.floating then
		clientProperties = clientProperties .. " f |"
		propertyCount = propertyCount + 1
	end

	if client.sticky then
		clientProperties = clientProperties .. " S |"
		propertyCount = propertyCount + 1
	end

	if client.ontop then
		clientProperties = clientProperties .. " O |"
		propertyCount = propertyCount + 1
	end

	clientProperties_sm.main.text = clientProperties
	if propertyCount == 0 then
		clientProperties_sm.wibox.visible = false
	else
		clientProperties_sm.wibox.visible = true
	end
end

AwesomeWM.awful.placement.bottom_left(clientProperties_sm.wibox, { margins = 0 })
return clientProperties_sm
