local clients_sm = {}

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

clients_sm.initClients = function()
	clients_sm.list = {
		{
			rule = {},
			description = "Rule for all clients",
			properties = {
				border_width = AwesomeWM.beautiful.border_width,
				border_color = AwesomeWM.beautiful.border_normal,
				focus = AwesomeWM.awful.client.focus.filter,
				raise = true,
				buttons = AwesomeWM.keymaps.getClientButtons(),
				screen = AwesomeWM.awful.screen.preferred,
				placement = AwesomeWM.awful.placement.no_overlap + AwesomeWM.awful.placement.no_offscreen,
				size_hints_honor = true,
			},
		},
		{
			rule = { class = "firefox" },
			description = "Rule for firefox",
			properties = {
				floating = false,
				maximized = false,
			},
		},
		{
			rule = { class = "Dragon-drop" },
			description = "Rule for dragon drop",
			properties = {
				floating = true,
				ontop = true,
				placement = AwesomeWM.awful.placement.top_right,
			},
		},
		{
			rule = { class = "firefox", role = "toolbox" },
			description = "Rule for firefox inspector",
			properties = {
				floating = true,
				placement = AwesomeWM.awful.placement.top_right,
			},
		},
		{
			rule = { class = "Blender" },
			description = "Rule for blender",
			properties = {
				floating = false,
				fullscreen = false,
			},
		},
		{
			rule = { role = "GtkFileChooserDialog" },
			description = "Rule for file chooser dialog",
			properties = {
				floating = true,
			},
		},
		{
			rule = { name = "Picture-in-Picture" },
			description = "Rule for picture in picture mode",
			properties = {
				floating = true,
				placement = AwesomeWM.awful.placement.top_right,
				size_hints_honor = true,
			},
		},
		{
			rule = { name = "Password Required - Mozilla Firefox" },
			description = "Rule for password input in firefox",
			properties = {
				floating = true,
				placement = AwesomeWM.awful.placement.top_left,
				size_hints_honor = true,
			},
		},
	}

	AwesomeWM.ruled.client.append_rules(clients_sm.list)

	AwesomeWM.client.connect_signal("unmanage", function(_client)
		AwesomeWM.widgets.indicators.clientCount.refresh()
	end)

	AwesomeWM.client.connect_signal("manage", function(_client)
		if
			AwesomeWM.awesome.startup
			and not _client.size_hints.user_position
			and not _client.size_hints.program_position
		then
			AwesomeWM.awful.placement.no_offscreen(_client)
		end

		AwesomeWM.widgets.indicators.clientCount.refresh()
	end)

	AwesomeWM.client.connect_signal("mouse::enter", function(_client)
		_client:emit_signal("request::activate", "mouse_enter", { raise = false })
	end)

	AwesomeWM.client.connect_signal("focus", function(_client)
		AwesomeWM.widgets.indicators.clentProperties.refresh(_client)
		AwesomeWM.widgets.indicators.minimizedBar.refresh()
		clients_sm.applyBorderColor(_client)
	end)

	AwesomeWM.client.connect_signal("unfocus", function(_client)
		AwesomeWM.widgets.indicators.clentProperties.refresh(_client)
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

clients_sm.maximizeClient = function()
	local formatItemString = function(c)
		local class = c.class or "Unknown"
		local pid = c.pid or "xxxxx"
		local name = c.name or "Application"

		return "[" .. class .. ":" .. pid .. "]" .. " " .. name .. "\n"
	end

	local rofiString = ""
	for _, c in ipairs(AwesomeWM.client.get()) do
		if c.minimized then
			rofiString = rofiString .. formatItemString(c)
		end
	end

	if rofiString == "" then
		return
	end

	AwesomeWM.awful.spawn.easy_async_with_shell(
		'echo -en "' .. rofiString .. '" | rofi -dmenu -i -p "Maximize: "',
		function(out, err, message)
			if out == "" then
				return
			end

			for _, c in pairs(AwesomeWM.client.get()) do
				if formatItemString(c) == out then
					c.minimized = false
					AwesomeWM.widgets.indicators.minimizedBar.refresh()
					c:jump_to()
				end
			end
		end
	)
end

clients_sm.getClientCount = function()
	local localCount = #(AwesomeWM.awful.screen.focused().selected_tag:clients())
	local globalCount = 0
	for _, _ in ipairs(AwesomeWM.client.get()) do
		globalCount = globalCount + 1
	end

	return { localCount = localCount, globalCount = globalCount }
end

clients_sm.toggleClientProperty = function(_propertyName)
	local focusedClient = AwesomeWM.client.focus
	local focusedTag = AwesomeWM.awful.screen.focused().selected_tag

	if focusedClient == nil then
		return
	end

	focusedClient[_propertyName] = not focusedClient[_propertyName]
	if focusedClient.sticky == false then
		focusedClient:move_to_tag(focusedTag)
	end

	clients_sm.applyBorderColor(focusedClient)
	AwesomeWM.widgets.indicators.clentProperties.refresh(focusedClient)
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

clients_sm.hasNotToKill = function()
	for _, c in ipairs(AwesomeWM.client.get()) do
		if c.notToKill then
			return true
		end
	end
	return false
end

return clients_sm
