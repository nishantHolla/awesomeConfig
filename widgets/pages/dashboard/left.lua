local dashboardLeft_c = {}
local dashboardComponents = AwesomeWM.widgets.pages.dashboard.components
local values_sm = AwesomeWM.widgets.pages.values
local helper_sm = AwesomeWM.widgets.pages.helper

-- top

dashboardLeft_c.top = {}

dashboardLeft_c.top = helper_sm.makeComponent({
	heading = "",
	noHeading = true,
	widget = dashboardComponents.title.main,
	overrides = {
		headingFontSize = 50,
		contentRatio = 0.6,
	},
})

-- center

dashboardLeft_c.center = helper_sm.makeComponent({
	heading = "Stats",
	widget = dashboardComponents.stats.main,
	overrides = {},
})

-- bottom

dashboardLeft_c.bottom = {}

dashboardLeft_c.bottom = helper_sm.makeComponent({
	heading = "Media",
	widget = dashboardComponents.media.main,
	overrides = {},
})

-- main

dashboardLeft_c.main = AwesomeWM.wibox.widget({
	dashboardLeft_c.top.main,
	dashboardLeft_c.center.main,
	dashboardLeft_c.bottom.main,
	spacing = values_sm.secondarySpacing,
	widget = AwesomeWM.wibox.layout.ratio.vertical,
})

dashboardLeft_c.top.main:connect_signal("button::press", function()
	AwesomeWM.widgets.pages.dashboard.toggle()
end)

dashboardLeft_c.main:ajust_ratio(2, 0.2, 0.5, 0.3)

return dashboardLeft_c
