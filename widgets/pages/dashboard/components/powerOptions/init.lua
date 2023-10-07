local powerOptionsComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper
local values_sm = AwesomeWM.widgets.pages.values

local makeOption = function(_iconName)
	return AwesomeWM.wibox.widget({
		image = AwesomeWM.assets.getIcon(_iconName),
		resize = true,
		widget = AwesomeWM.wibox.widget.imagebox,
	})
end

local overrides = {
	padding = 12,
	inactiveButtonBg = values_sm.inactiveContainerBg,
	activeButtonBg = values_sm.activeButtonBg,
	inactiveButtonBorderColor = AwesomeWM.beautiful.white,
}

-- shutdown

powerOptionsComponent.shutdown = {}
powerOptionsComponent.shutdown.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
-- powerOptionsComponent.shutdown.overrides.activeButtonBg = AwesomeWM.beautiful.red
-- powerOptionsComponent.shutdown.overrides.activeButtonBorderColor = AwesomeWM.beautiful.red
powerOptionsComponent.shutdown.button = helper_sm.makeButton({
	widget = makeOption("powerShutdownWhite"),
	onClick = function()
		AwesomeWM.functions.power.shutdown()
	end,
	overrides = powerOptionsComponent.shutdown.overrides,
})

-- restart

powerOptionsComponent.restart = {}
powerOptionsComponent.restart.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
-- powerOptionsComponent.restart.overrides.activeButtonBg = AwesomeWM.beautiful.green
-- powerOptionsComponent.restart.overrides.activeButtonBorderColor = AwesomeWM.beautiful.green
powerOptionsComponent.restart.button = helper_sm.makeButton({
	widget = makeOption("powerRestartWhite"),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell("reboot")
	end,
	overrides = powerOptionsComponent.restart.overrides,
})

-- lock

powerOptionsComponent.lock = {}
powerOptionsComponent.lock.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
-- powerOptionsComponent.lock.overrides.activeButtonBg = AwesomeWM.beautiful.yellow
-- powerOptionsComponent.lock.overrides.activeButtonBorderColor = AwesomeWM.beautiful.yellow
powerOptionsComponent.lock.button = helper_sm.makeButton({
	widget = makeOption("powerLockWhite"),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell("betterlockscreen -l")
	end,
	overrides = powerOptionsComponent.lock.overrides,
})

-- sleep

powerOptionsComponent.sleep = {}
powerOptionsComponent.sleep.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
-- powerOptionsComponent.sleep.overrides.activeButtonBg = AwesomeWM.beautiful.blue
-- powerOptionsComponent.sleep.overrides.activeButtonBorderColor = AwesomeWM.beautiful.blue
powerOptionsComponent.sleep.button = helper_sm.makeButton({
	widget = makeOption("powerSleepWhite"),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell("systemctl suspend")
	end,
	overrides = powerOptionsComponent.sleep.overrides,
})

-- logout

powerOptionsComponent.logout = {}
powerOptionsComponent.logout.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
-- powerOptionsComponent.logout.overrides.activeButtonBg = AwesomeWM.beautiful.orange
-- powerOptionsComponent.logout.overrides.activeButtonBorderColor = AwesomeWM.beautiful.orange
powerOptionsComponent.logout.button = helper_sm.makeButton({
	widget = makeOption("powerLogoutWhite"),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell("kill -9 -1")
	end,
	overrides = powerOptionsComponent.logout.overrides,
})

-- layout

powerOptionsComponent.layout = AwesomeWM.wibox.widget({
	powerOptionsComponent.shutdown.button.main,
	powerOptionsComponent.restart.button.main,
	powerOptionsComponent.lock.button.main,
	powerOptionsComponent.sleep.button.main,
	powerOptionsComponent.logout.button.main,
	spacing = 25,
	layout = AwesomeWM.wibox.layout.flex.horizontal,
})

powerOptionsComponent.main = AwesomeWM.wibox.widget({
	{
		powerOptionsComponent.layout,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin,
	},
	valign = "center",
	align = "center",
	widget = AwesomeWM.wibox.container.place,
})

return powerOptionsComponent
