
local assets_m = {}

assets_m.assetsDir = AwesomeWM.values.awesomeDir .. '/assets'
assets_m.wallpaperDir = assets_m.assetsDir .. '/wallpapers'
assets_m.layoutsDir = assets_m.assetsDir .. '/layouts'

assets_m.getIcon = function(_iconName)
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

assets_m.getLayout = function(_layoutName)
	_layoutName = _layoutName or tostring(AwesomeWM.awful.screen.focused().selected_tag.layout.name)
	if _layoutName ~= 'spiral' and _layoutName ~= 'fullscreen' and _layoutName ~= 'floating' and _layoutName ~= 'fairh' then return '' end
	return (assets_m.layoutsDir .. '/' .. _layoutName .. '.jpg')
end

assets_m.getWallpaper = function(_tagName)

	local focusedScreen = AwesomeWM.awful.screen.focused()

	if _tagName then
		local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, _tagName)
		if tag then return (assets_m.wallpaperDir .. '/' .. _tagName) end
	elseif focusedScreen.selected_tag then
		return (assets_m.wallpaperDir .. '/' .. focusedScreen.selected_tag.name)
	end

	return (assets_m.wallpaperDir .. '/default')
end

assets_m.getVolumeIcon = function(_volume)
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

assets_m.getBrightnessIcon = function(_brightness)
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

return assets_m
