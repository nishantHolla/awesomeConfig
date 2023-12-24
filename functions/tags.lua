local tags_sm = {}

tags_sm.moveToTag = function(_tagName)
	local focusedScreen = AwesomeWM.awful.screen.focused()
	local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, _tagName)

	if _tagName == "next" then
		AwesomeWM.awful.tag.viewnext(focusedScreen)
	elseif _tagName == "previous" then
		AwesomeWM.awful.tag.viewprev(focusedScreen)
	elseif _tagName then
		tag:view_only()
	end

	AwesomeWM.theme.setWallpaper()
	AwesomeWM.widgets.indicators.clientCount.refresh()

	if AwesomeWM.widgets.pages.dashboard.wibox.visible then
		AwesomeWM.widgets.pages.dashboard.components.tags.refresh()
	else
		AwesomeWM.widgets.indicators.tags.show()
	end
	AwesomeWM.widgets.indicators.clentProperties.refresh()
end

tags_sm.cycleLayout = function(_order)
	AwesomeWM.awful.layout.inc(_order)

	if AwesomeWM.widgets.pages.dashboard.wibox.visible then
		AwesomeWM.widgets.pages.dashboard.components.tags.refresh()
	else
		AwesomeWM.widgets.indicators.tags.show()
	end
end

tags_sm.getState = function(_tagName)
	local selectedTag = AwesomeWM.awful.screen.focused().selected_tag.name
	local values = {}

	if _tagName == selectedTag then
		values.state = "active"
		values.colors = {
			border = AwesomeWM.beautiful.tagIndicatorActiveBorderColor,
			background = AwesomeWM.beautiful.tagIndicatorActiveBackground,
		}

		return values
	end

	local currentTag = AwesomeWM.awful.tag.find_by_name(AwesomeWM.awful.screen.focused(), _tagName)
	local count = #(currentTag:clients())

	if count == 0 then
		values.state = "dead"
		values.colors = {
			border = AwesomeWM.beautiful.tagIndicatorDeadBorderColor,
			background = AwesomeWM.beautiful.tagIndicatorDeadBackground,
		}
	else
		values.state = "alive"
		values.colors = {
			border = AwesomeWM.beautiful.tagIndicatorAliveBorderColor,
			background = AwesomeWM.beautiful.tagIndicatorAliveBackground,
		}
	end

	return values
end

return tags_sm
