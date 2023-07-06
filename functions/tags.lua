
local module = {}

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
	AwesomeWM.widgets.list.tagsIndicator.show()

end

module.cycleLayout = function(_order)
	AwesomeWM.awful.layout.inc(_order)
	AwesomeWM.widgets.list.tagsIndicator.show()
end

return module
