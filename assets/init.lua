-- Assets module

local module = {}
module.wallpaperDir = AwesomeWM.values.awesomeDir .. '/assets/wallpapers'

module.getIcon = function(_iconName)
	return ('/usr/share/icons/GI/GI_' .. _iconName .. '.svg')
end

module.getWallpaper = function(_tagName)

	local focusedScreen = AwesomeWM.awful.screen.focused()

	if _tagName then
		local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, _tagName)
		if tag then return (module.wallpaperDir .. '/' .. _tagName .. '.jpg') end
	elseif focusedScreen.selected_tag then
		return (module.wallpaperDir .. '/' .. focusedScreen.selected_tag.name .. '.jpg')
	end

	return (module.wallpaperDir .. '/default.jpg')
end

return module
