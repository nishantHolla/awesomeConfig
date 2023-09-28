local dashboardRight_c = {}
local dashboardComponents = AwesomeWM.widgets.pages.dashboard.components
local values_sm = AwesomeWM.widgets.pages.values
local helper_sm = AwesomeWM.widgets.pages.helper

-- top

dashboardRight_c.top = {}

dashboardRight_c.top = helper_sm.makeComponent({
	heading = "Power Options",
	widget = dashboardComponents.powerOptions.main,
	overrides = {
		contentRatio = 0.65,
	},
})

-- center

dashboardRight_c.center = {}

dashboardRight_c.center = helper_sm.makeComponent({
	heading = "Notes",
	widget = dashboardComponents.notes.main,
	overrides = {
		contentRatio = 0.95,
	},
})

-- bottom

dashboardRight_c.bottom = {}

dashboardRight_c.bottom = helper_sm.makeComponent({
	heading = "System Tray",
	widget = dashboardComponents.systemTray.main,
	overrides = {
		contentRatio = 0.6,
	},
})

-- main

dashboardRight_c.main = AwesomeWM.wibox.widget({
	dashboardRight_c.top.main,
	dashboardRight_c.center.main,
	dashboardRight_c.bottom.main,
	spacing = values_sm.secondarySpacing,
	widget = AwesomeWM.wibox.layout.ratio.vertical,
})

dashboardRight_c.main:ajust_ratio(2, 0.1, 0.8, 0.1)

return dashboardRight_c
