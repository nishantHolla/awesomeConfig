-- Functions module

local module = {}

module.initErrorHandling = function()

	-- startup errors
	if AwesomeWM.awesome.startup_errors then

		AwesomeWM.notify.critical('Startup error encountered', AwesomeWM.awesome.startup_errors)
	end

	-- runtime errors
	do
		local inError = false
		AwesomeWM.awesome.connect_signal('debug::error', function(errorMessage)
			if inError then return end
			inError = true

			AwesomeWM.notify.critical('Runtime error encountered', tostring(errorMessage))
			inError = false
		end)
	end
end

module.initScreens = function()
	AwesomeWM.screen.connect_signal('property::geometry', AwesomeWM.theme.setWallpaper)

	AwesomeWM.awful.screen.connect_for_each_screen(function(_screen)
		local tags = {}
		for _, t in pairs(AwesomeWM.values.tags) do
			table.insert(tags, t.name)
		end
		AwesomeWM.awful.tag(tags, _screen, AwesomeWM.values.tagLayouts[1])
		AwesomeWM.theme.setWallpaper()


	end)
end
module.initClients = function()
	AwesomeWM.awful.rules.rules = {
		{
			rule = {},
			properties = {
				border_width = AwesomeWM.beautiful.border_width,
				border_color = AwesomeWM.beautiful.border_normal,
				focus = AwesomeWM.awful.client.focus.filter,
				raise = true,
				screen = AwesomeWM.awful.screen.preferred,
				placement = AwesomeWM.awful.placement.no_overlap + AwesomeWM.awful.placement.no_offscreen
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
		AwesomeWM.functions.applyBorderColor(_client)
	end)

	AwesomeWM.client.connect_signal('unfocus', function(_client)
		_client.border_color = AwesomeWM.beautiful.border_normal
	end)

	AwesomeWM.awful.spawn('picom')

end

module.moveToTag = function(_tagName)

	local focusedScreen = AwesomeWM.awful.screen.focused()
	local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, _tagName)
	
	if _tagName == 'next' then
		AwesomeWM.awful.tag.viewnext(focusedScreen)
	elseif _tagName == 'previous' then
		AwesomeWM.awful.tag.viewprev(focusedScreen)
	elseif _tagName then
		tag:view_only()
	end

	AwesomeWM.theme.setWallpaper()
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

	AwesomeWM.functions.applyBorderColor(focusedClient)

end

module.applyBorderColor = function(_client)
	if _client.floating then _client.border_color = AwesomeWM.beautiful.border_floating
	elseif _client.sticky then _client.border_color = AwesomeWM.beautiful.border_sticky
	elseif _client.fullscreen then _client.border_color = AwesomeWM.beautiful.border_fullscreen
	else _client.border_color = AwesomeWM.beautiful.border_focus
	end
end

module.isFile = function(_filePath)
	local f = io.open(_filePath, 'r')

	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

module.restart = function()
	AwesomeWM.awesome.restart()
end

module.volume = require('functions.volume')
module.brightness = require('functions.brightness')
module.player = require('functions.player')

return module
