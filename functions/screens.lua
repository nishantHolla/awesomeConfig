local screens_sm = {}

screens_sm.initScreens = function()
	AwesomeWM.screen.connect_signal("property::geometry", AwesomeWM.theme.setWallpaper)

	AwesomeWM.awful.screen.connect_for_each_screen(function(_screen)
		local tags = {}
		for _, t in pairs(AwesomeWM.values.tags) do
			table.insert(tags, t.name)
		end
		AwesomeWM.awful.tag(tags, _screen, AwesomeWM.values.tagLayouts[1])
		AwesomeWM.theme.setWallpaper()
	end)
end

return screens_sm
