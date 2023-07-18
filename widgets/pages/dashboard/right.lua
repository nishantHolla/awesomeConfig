
local dashboardRight_c = {}
local values_sm = AwesomeWM.widgets.pages.values
local helper_sm = AwesomeWM.widgets.pages.helper

-- top

dashboardRight_c.top = {}

dashboardRight_c.top = helper_sm.makeComponent({
	heading = 'Power Options',
	widget = AwesomeWM.widgets.testWidget('power options widget'),
	overrides = {
		contentRatio = 0.7
	}
})

-- center

dashboardRight_c.center = {}

dashboardRight_c.center = helper_sm.makeComponent({
	heading = 'Notification',
	widget = AwesomeWM.widgets.testWidget('notification widget'),
	overrides = {}
})

-- bottom

dashboardRight_c.bottom = {}

dashboardRight_c.bottom = helper_sm.makeComponent({
	heading = 'System Tray',
	widget = AwesomeWM.widgets.testWidget('system tray widget'),
	overrides = {
		contentRatio = 0.5
	}
})

-- main

dashboardRight_c.main = AwesomeWM.wibox.widget({
	dashboardRight_c.top.main,
	dashboardRight_c.center.main,
	dashboardRight_c.bottom.main,
	spacing = values_sm.secondarySpacing,
	widget = AwesomeWM.wibox.layout.ratio.vertical
})

dashboardRight_c.main:ajust_ratio(2, 0.1, 0.8, 0.1)

return dashboardRight_c
