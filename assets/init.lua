-- Assets module

local module = {}
module.assetsDir = AwesomeWM.values.awesomeDir .. '/assets'
module.wallpaperDir = module.assetsDir .. '/wallpapers'
module.layoutsDir = module.assetsDir .. '/layouts'

module.getIcon = function(_iconName)
	local location1 = '/usr/share/icons/GI/GI_' .. _iconName .. '.svg'

	if AwesomeWM.functions.isFile(location1) then
		return location1
	end

	local location2 = os.getenv('HOME') .. '/.local/share/icons/GI/GI_' .. _iconName .. '.svg'

	if AwesomeWM.functions.isFile(location2) then
		return location2
	end

	return ''

end

module.getLayout = function(_layoutName)
	_layoutName = _layoutName or tostring(AwesomeWM.awful.screen.focused().selected_tag.layout.name)
	if _layoutName ~= 'spiral' and _layoutName ~= 'fullscreen' and _layoutName ~= 'floating' and _layoutName ~= 'fairh' then return '' end
	return (module.layoutsDir .. '/' .. _layoutName .. '.jpg')
end

module.getWallpaper = function(_tagName)

	local focusedScreen = AwesomeWM.awful.screen.focused()

	if _tagName then
		local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, _tagName)
		if tag then return (module.wallpaperDir .. '/' .. _tagName) end
	elseif focusedScreen.selected_tag then
		return (module.wallpaperDir .. '/' .. focusedScreen.selected_tag.name)
	end

	return (module.wallpaperDir .. '/default')
end

module.getVolumeIcon = function(_volume)
	local icon = nil

	if _volume > 75 then
		icon = AwesomeWM.assets.getIcon('volumeHighWhite')
	elseif _volume > 25 then
		icon = AwesomeWM.assets.getIcon('volumeMediumWhite')
	elseif _volume > 0 then
		icon = AwesomeWM.assets.getIcon('volumeLowWhite')
	else
		icon = AwesomeWM.assets.getIcon('volumeMuteWhite')
	end

	return icon
end

module.getBrightnessIcon = function(_brightness)
	local icon = nil

	if _brightness > 180 then
		icon = AwesomeWM.assets.getIcon('brightnessHighWhite')
	elseif _brightness > 80 then
		icon = AwesomeWM.assets.getIcon('brightnessMediumWhite')
	else
		icon = AwesomeWM.assets.getIcon('brightnessLowWhite')
	end

	return icon
end

return module
