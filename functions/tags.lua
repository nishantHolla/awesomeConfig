
local tags_sm = {}

tags_sm.moveToTag = function(_tagName)

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
	AwesomeWM.widgets.indicators.tags.show()
	AwesomeWM.functions.clients.setClientCount()

end

tags_sm.cycleLayout = function(_order)
	AwesomeWM.awful.layout.inc(_order)
	AwesomeWM.widgets.indicators.tags.show()
end

tags_sm.getColor = function(_tagName)
	local selectedTag = AwesomeWM.awful.screen.focused().selected_tag.name

	if _tagName == selectedTag then
		return {AwesomeWM.beautiful.tagIndicatorActiveBorderColor, AwesomeWM.beautiful.tagIndicatorActiveBackground}
	end

	local currentTag = AwesomeWM.awful.tag.find_by_name(AwesomeWM.awful.screen.focused(), _tagName)
	local count = #(currentTag:clients())

	if count == 0 then
		return {AwesomeWM.beautiful.tagIndicatorDeadBorderColor, AwesomeWM.beautiful.tagIndicatorDeadBackground}
	else
		return {AwesomeWM.beautiful.tagIndicatorAliveBorderColor, AwesomeWM.beautiful.tagIndicatorAliveBackground}
	end

end

return tags_sm
