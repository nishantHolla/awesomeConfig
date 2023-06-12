-- Assets module

local module = {}
module.wallpaperDir = AwesomeWM.values.awesomeDir .. '/assets/wallpapers'

module.getIcon = function(_iconName)
	local location1 = '/usr/share/icons/GI/GI_' .. _iconName .. '.svg'
	local f1 = io.open(location1, 'r')

	if f1 ~= nil then
		io.close(f1)
		return location1
	end

	local location2 = os.getenv('HOME') .. '/.local/share/icons/GI/GI_' .. _iconName .. '.svg'
	local f2 = io.open(location2, 'r')
	
	if f2 ~= nil then
		io.close(f2)
		return location2
	end

	return ''

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
