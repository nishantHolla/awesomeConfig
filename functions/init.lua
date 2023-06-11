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
		_client.border_color = AwesomeWM.beautiful.border_focus
	end)

	AwesomeWM.client.connect_signal('unfocus', function(_client)
		_client.border_color = AwesomeWM.beautiful.border_normal
	end)

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


return module
