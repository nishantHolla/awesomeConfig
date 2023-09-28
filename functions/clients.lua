local clients_sm = {}

clients_sm.initClients = function()
	AwesomeWM.awful.rules.rules = {
		{
			rule = {},
			properties = {
				border_width = AwesomeWM.beautiful.border_width,
				border_color = AwesomeWM.beautiful.border_normal,
				focus = AwesomeWM.awful.client.focus.filter,
				raise = true,
				buttons = AwesomeWM.keymaps.getClientButtons(),
				screen = AwesomeWM.awful.screen.preferred,
				placement = AwesomeWM.awful.placement.no_overlap + AwesomeWM.awful.placement.no_offscreen,
			},
		},

		{
			rule = { class = "firefox" },
			properties = {
				fullscreen = false,
				floating = false,
				maximized = false,
			},
		},

		{
			rule = { class = "Blender" },
			properties = {
				fullscreen = false,
				maximized = false,
				floating = false,
			},
		},

		{
			rule = { role = "GtkFileChooserDialog" },
			properties = {
				floating = true,
			},
		},

		{
			rule = { name = "Picture-in-Picture" },
			properties = {
				floating = true,
			},
		},
	}

	AwesomeWM.client.connect_signal("unmanage", function(_client)
		AwesomeWM.functions.clients.setClientCount()
	end)

	AwesomeWM.client.connect_signal("manage", function(_client)
		if
			AwesomeWM.awesome.startup
			and not _client.size_hints.user_position
			and not _client.size_hints.program_position
		then
			AwesomeWM.awful.placement.no_offscreen(_client)
		end

		AwesomeWM.functions.clients.setClientCount()
	end)

	AwesomeWM.client.connect_signal("mouse::enter", function(_client)
		_client:emit_signal("request::activate", "mouse_enter", { raise = false })
	end)

	AwesomeWM.client.connect_signal("focus", function(_client)
		clients_sm.applyBorderColor(_client)
	end)

	AwesomeWM.client.connect_signal("unfocus", function(_client)
		_client.border_color = AwesomeWM.beautiful.border_normal
	end)

	AwesomeWM.client.connect_signal("property::urgent", function(c)
		if c.class == "firefox" then
			AwesomeWM.awful.client.urgent.jumpto(false)
		end
	end)

	-- startup applications
	AwesomeWM.awful.spawn("picom")
	AwesomeWM.awful.spawn("nm-applet")
	AwesomeWM.awful.spawn("flameshot")
	AwesomeWM.awful.spawn("playerctld daemon")
end

clients_sm.getClientCount = function()
	local localCount = #(AwesomeWM.awful.screen.focused().selected_tag:clients())
	local globalCount = 0
	for _, _ in ipairs(client.get()) do
		globalCount = globalCount + 1
	end

	return { localCount = localCount, globalCount = globalCount }
end

clients_sm.setClientCount = function()
	local clientCount = AwesomeWM.functions.clients.getClientCount()
	local text = tostring(clientCount.localCount) .. "|" .. tostring(clientCount.globalCount)
	AwesomeWM.widgets.indicators.clientCount.main.text = text
end

clients_sm.toggleClientProperty = function(_propertyName)
	local focusedClient = AwesomeWM.client.focus
	local focusedTag = AwesomeWM.awful.screen.focused().selected_tag

	if focusedClient == nil then
		return
	end

	if _propertyName == "sticky" then
		if focusedClient.sticky == false then
			focusedClient.sticky = true
		else
			focusedClient.sticky = false
			focusedClient:move_to_tag(focusedTag)
		end
	elseif _propertyName == "fullscreen" then
		if focusedClient.fullscreen == false then
			focusedClient.fullscreen = true
		else
			focusedClient.fullscreen = false
		end
	elseif _propertyName == "floating" then
		if focusedClient.floating == false then
			focusedClient.floating = true
		else
			focusedClient.floating = false
		end
	elseif _propertyName == "notToKill" then
		if focusedClient.notToKill then
			focusedClient.notToKill = false
		else
			focusedClient.notToKill = true
		end
	end

	clients_sm.applyBorderColor(focusedClient)
end

clients_sm.applyBorderColor = function(_client)
	if _client.notToKill then
		_client.border_color = AwesomeWM.beautiful.white
	elseif _client.floating then
		_client.border_color = AwesomeWM.beautiful.border_floating
	elseif _client.sticky then
		_client.border_color = AwesomeWM.beautiful.border_sticky
	elseif _client.fullscreen then
		_client.border_color = AwesomeWM.beautiful.border_fullscreen
	else
		_client.border_color = AwesomeWM.beautiful.border_focus
	end
end

return clients_sm
