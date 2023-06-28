
local module = {}

module.initClients = function()
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
			}

		},

		{
			rule = {class = "firefox"},
			properties = {
				floating = false,
				maximized = false,
			}
		},

		{
			rule = {class = "Blender"},
			properties = {
				fullscreen = false,
				maximized = false,
				floating = false,
			}
		},

		{
			rule = {role = "GtkFileChooserDialog"},
			properties = {
				floating = true,
			}
		}
	}

	AwesomeWM.client.connect_signal('manage', function(_client)
		if AwesomeWM.awesome.startup
		 and not _client.size_hints.user_position
		 and not _client.size_hints.program_position then
		 	AwesomeWM.awful.placement.no_offscreen(_client)
		end
	end)

	AwesomeWM.client.connect_signal('mouse::enter', function(_client)
		_client:emit_signal('request::activate', 'mouse_enter', {raise = true})
	end)

	AwesomeWM.client.connect_signal('focus', function(_client)
		module.applyBorderColor(_client)
	end)

	AwesomeWM.client.connect_signal('unfocus', function(_client)
		_client.border_color = AwesomeWM.beautiful.border_normal
	end)

	-- startup applications
	AwesomeWM.awful.spawn('picom')
	AwesomeWM.awful.spawn('nm-applet')
	AwesomeWM.awful.spawn('flameshot')

end

module.toggleClientProperty = function(_propertyName)
	local focusedClient = AwesomeWM.client.focus
	local focusedTag = AwesomeWM.awful.screen.focused().selected_tag
	
	if focusedClient == nil then return end

	if _propertyName == 'sticky' then
		if focusedClient.sticky == false then
			focusedClient.sticky = true
		else
			focusedClient.sticky = false
			focusedClient:move_to_tag(focusedTag)
		end

	elseif _propertyName == 'fullscreen' then
		if focusedClient.fullscreen == false then
			focusedClient.fullscreen = true
		else
			focusedClient.fullscreen = false
		end
	
	elseif _propertyName == 'floating' then
		if focusedClient.floating == false then
			focusedClient.floating = true
		else
			focusedClient.floating = false
		end
	end

	module.applyBorderColor(focusedClient)

end

module.applyBorderColor = function(_client)
	if _client.floating then _client.border_color = AwesomeWM.beautiful.border_floating
	elseif _client.sticky then _client.border_color = AwesomeWM.beautiful.border_sticky
	elseif _client.fullscreen then _client.border_color = AwesomeWM.beautiful.border_fullscreen
	else _client.border_color = AwesomeWM.beautiful.border_focus
	end
end

return module
