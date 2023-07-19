
local dashboardMiddle_c = {}
local dashboardComponents = AwesomeWM.widgets.pages.dashboard.components
local values_sm = AwesomeWM.widgets.pages.values
local helper_sm = AwesomeWM.widgets.pages.helper

-- top

dashboardMiddle_c.top = {}

dashboardMiddle_c.top = helper_sm.makeComponent({
	heading = 'Tags',
	widget = dashboardComponents.tags.main,
	overrides = {
		contentRatio = 0.6
	}
})

-- center

dashboardMiddle_c.center = {}

dashboardMiddle_c.center.above = helper_sm.makeComponent({
	heading = 'Profile',
	widget = AwesomeWM.widgets.testWidget('profile widget'),
	overrides = {
		contentRatio = 0.9
	}
})

dashboardMiddle_c.center.below = {}
dashboardMiddle_c.center.below.left = helper_sm.makeComponent({
	heading = 'Weather',
	widget = AwesomeWM.widgets.testWidget('weather widget'),
	overrides = {
		contentRatio = 0.9
	}
})

dashboardMiddle_c.center.below.right = helper_sm.makeComponent({
	heading = 'Time And Date',
	widget = dashboardComponents.time.main,
	overrides = {
		contentRatio = 0.9
	}
})

dashboardMiddle_c.center.below.main = AwesomeWM.wibox.widget({
	dashboardMiddle_c.center.below.left.main,
	dashboardMiddle_c.center.below.right.main,
	spacing = -1,
	widget = AwesomeWM.wibox.layout.ratio.horizontal
})

dashboardMiddle_c.center.main = AwesomeWM.wibox.widget({
	dashboardMiddle_c.center.above.main,
	dashboardMiddle_c.center.below.main,
	widget = AwesomeWM.wibox.layout.ratio.vertical
})

-- bottom

dashboardMiddle_c.bottom = {}

dashboardMiddle_c.bottom = helper_sm.makeComponent({
	heading = 'Quick launch',
	widget = AwesomeWM.widgets.testWidget('quick launch widget'),
	overrides = {
		contentRatio = 0.6
	}
})

-- main

dashboardMiddle_c.main = AwesomeWM.wibox.widget({
	dashboardMiddle_c.top.main,
	dashboardMiddle_c.center.main,
	dashboardMiddle_c.bottom.main,
	spacing = values_sm.secondarySpacing,
	widget = AwesomeWM.wibox.layout.ratio.vertical
})

dashboardMiddle_c.main:ajust_ratio(2, 0.1, 0.8, 0.1)

return dashboardMiddle_c
