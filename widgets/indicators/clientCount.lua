local clientCount_sm = {}

clientCount_sm.width = 35
clientCount_sm.height = 15
clientCount_sm.opacity = 0.5

clientCount_sm.main = AwesomeWM.wibox.widget({
	text = "0",
	align = "center",
	valign = "center",
	font = AwesomeWM.beautiful.defaultFont .. " 10",
	widget = AwesomeWM.wibox.widget.textbox,
})

clientCount_sm.wibox = AwesomeWM.wibox({
	widget = clientCount_sm.main,
	visible = true,
	opacity = clientCount_sm.opacity,
	ontop = true,
	type = "desktop",
	bg = "#000000",
	height = clientCount_sm.height,
	width = clientCount_sm.width,
})

clientCount_sm.refresh = function()
	local clientCount = AwesomeWM.functions.clients.getClientCount()
	local text = tostring(clientCount.localCount) .. "|" .. tostring(clientCount.globalCount)
	AwesomeWM.widgets.indicators.clientCount.main.text = text
end

AwesomeWM.awful.placement.top_left(clientCount_sm.wibox, { margins = 0 })
return clientCount_sm
