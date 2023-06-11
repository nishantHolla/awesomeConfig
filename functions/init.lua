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
