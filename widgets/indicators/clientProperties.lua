local clientProperties_sm = {}

clientProperties_sm.propertyWidth = 40
clientProperties_sm.width = clientProperties_sm.propertyWidth
clientProperties_sm.height = 15
clientProperties_sm.opacity = 0.5

clientProperties_sm.main = AwesomeWM.wibox.widget({
	text = "0",
	align = "center",
	valign = "center",
	font = AwesomeWM.beautiful.defaultFont .. " 10",
	widget = AwesomeWM.wibox.widget.textbox,
})

clientProperties_sm.wibox = AwesomeWM.wibox({
	widget = clientProperties_sm.main,
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

	if propertyCount ~= 0 then
		clientProperties_sm.wibox.width = propertyCount * clientProperties_sm.propertyWidth
	end
	clientProperties_sm.main.text = clientProperties
end

AwesomeWM.awful.placement.bottom_left(clientProperties_sm.wibox, { margins = 0 })
return clientProperties_sm
