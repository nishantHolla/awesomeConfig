
local powerOptionsComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper
local values_sm = AwesomeWM.widgets.pages.values

local makeOption = function(_iconName)
	return AwesomeWM.wibox.widget({
		image = AwesomeWM.assets.getIcon(_iconName),
		resize = true,
		widget = AwesomeWM.wibox.widget.imagebox
	})
end

local overrides = {
	padding = 10,
	inactiveButtonBg = values_sm.inactiveContainerBg,
	activeButtonBg = values_sm.activeContainerBg,
	inactiveButtonBorderColor = AwesomeWM.beautiful.black
}

-- shutdown

powerOptionsComponent.shutdown = {}
powerOptionsComponent.shutdown.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
powerOptionsComponent.shutdown.overrides.activeButtonBorderColor = AwesomeWM.beautiful.redBright
powerOptionsComponent.shutdown.button = helper_sm.makeButtion({
	widget = makeOption('powerShutdownWhite'),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell('sis power shutdown')
	end,
	overrides = powerOptionsComponent.shutdown.overrides
})

-- restart

powerOptionsComponent.restart = {}
powerOptionsComponent.restart.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
powerOptionsComponent.restart.overrides.activeButtonBorderColor = AwesomeWM.beautiful.greenBright
powerOptionsComponent.restart.button = helper_sm.makeButtion({
	widget = makeOption('powerRestartWhite'),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell('sis power restart')
	end,
	overrides = powerOptionsComponent.restart.overrides
})

-- lock

powerOptionsComponent.lock = {}
powerOptionsComponent.lock.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
powerOptionsComponent.lock.overrides.activeButtonBorderColor = AwesomeWM.beautiful.yellowBright
powerOptionsComponent.lock.button = helper_sm.makeButtion({
	widget = makeOption('powerLockWhite'),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell('sis power lock')
	end,
	overrides = powerOptionsComponent.lock.overrides
})

-- sleep

powerOptionsComponent.sleep = {}
powerOptionsComponent.sleep.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
powerOptionsComponent.sleep.overrides.activeButtonBorderColor = AwesomeWM.beautiful.blueBright
powerOptionsComponent.sleep.button = helper_sm.makeButtion({
	widget = makeOption('powerSleepWhite'),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell('sis power sleep')
	end,
	overrides = powerOptionsComponent.sleep.overrides
})

-- logout

powerOptionsComponent.logout = {}
powerOptionsComponent.logout.overrides = AwesomeWM.functions.table.shallowCopy(overrides)
powerOptionsComponent.logout.overrides.activeButtonBorderColor = AwesomeWM.beautiful.black
powerOptionsComponent.logout.button = helper_sm.makeButtion({
	widget = makeOption('powerLogoutWhite'),
	onClick = function()
		AwesomeWM.awful.spawn.with_shell('sis power logout')
	end,
	overrides = powerOptionsComponent.logout.overrides
})

-- layout

powerOptionsComponent.layout = AwesomeWM.wibox.widget({
	powerOptionsComponent.shutdown.button.main,
	powerOptionsComponent.restart.button.main,
	powerOptionsComponent.lock.button.main,
	powerOptionsComponent.sleep.button.main,
	powerOptionsComponent.logout.button.main,
	spacing = 25,
	layout = AwesomeWM.wibox.layout.flex.horizontal
})

powerOptionsComponent.main = AwesomeWM.wibox.widget({
	{
		powerOptionsComponent.layout,
		margins = 10,
		widget = AwesomeWM.wibox.container.margin
	},
	valign = 'center',
	align = 'center',
	widget = AwesomeWM.wibox.container.place
})

return powerOptionsComponent
