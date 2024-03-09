local tagsComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper
local values_sm = AwesomeWM.widgets.pages.values

tagsComponent.layout = AwesomeWM.wibox.widget({
	spacing = 35,
	widget = AwesomeWM.wibox.layout.fixed.horizontal,
})

tagsComponent.refresh = function()
	tagsComponent.tagButtons = {}
	tagsComponent.layout:reset()

	tagsComponent.layoutImage = AwesomeWM.wibox.widget({
		image = AwesomeWM.assets.getLayout(),
		resize = true,
		widget = AwesomeWM.wibox.widget.imagebox,
	})

	tagsComponent.layout:add(AwesomeWM.wibox.widget({
		tagsComponent.layoutImage,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin,
	}))

	for _, tag in pairs(AwesomeWM.values.tags) do
		local tagText = AwesomeWM.wibox.widget({
			valign = "center",
			align = "center",
			font = AwesomeWM.beautiful.pagesFont .. " 15",
			text = tag.name,
			widget = AwesomeWM.wibox.widget.textbox,
		})

		local tagState = AwesomeWM.functions.tags.getState(tag.name)
		local colors = {}

		if tagState.state == "active" then
			colors.border = tagState.colors.border
			colors.background = tagState.colors.background
		elseif tagState.state == "alive" then
			colors.border = tagState.colors.border
			colors.background = tagState.colors.background
		elseif tagState.state == "dead" then
			colors.border = values_sm.inactiveButtonBorderColor
			colors.background = values_sm.inactiveButtonFg
		end

		local overrides = {
			inactiveButtonBg = values_sm.inactiveContainerBg,
			inactiveButtonBorderColor = colors.border,
			inactiveButtonFg = colors.background,
		}

		tagsComponent.tagButtons[tag.name] = helper_sm.makeButton({
			widget = tagText,
			onClick = function()
				AwesomeWM.functions.tags.moveToTag(tag.name)
			end,
			overrides = overrides,
		})

		tagsComponent.layout:add(tagsComponent.tagButtons[tag.name].main)
	end
end

tagsComponent.main = AwesomeWM.wibox.widget({
	tagsComponent.layout,
	valign = "center",
	align = "center",
	widget = AwesomeWM.wibox.container.place,
})

return tagsComponent
