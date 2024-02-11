local userProfileComponent = {}
local helper_sm = AwesomeWM.widgets.pages.helper

userProfileComponent.image = AwesomeWM.wibox.widget({
	image = AwesomeWM.assets.getAsset("images/profile.png"),
	resize = true,
	widget = AwesomeWM.wibox.widget.imagebox,
})

userProfileComponent.text = AwesomeWM.wibox.widget({
	align = "center",
	valign = "center",
	font = AwesomeWM.beautiful.pagesFont .. " 40",
	text = os.getenv("USER"),
	widget = AwesomeWM.wibox.widget.textbox,
})

userProfileComponent.left = AwesomeWM.wibox.widget({
	{
		userProfileComponent.image,
		aling = "center",
		valign = "center",
		widget = AwesomeWM.wibox.container.place,
	},
	userProfileComponent.text,
	widget = AwesomeWM.wibox.layout.ratio.vertical,
})

userProfileComponent.links = {
	{
		name = "gmailLink",
		text = AwesomeWM.values.gmailID,
		test = AwesomeWM.values.gmailID,
		icon = "󰊫",
		activeColor = AwesomeWM.beautiful.red,
		inactiveColor = AwesomeWM.beautiful.red,
		onClick = function()
			AwesomeWM.awful.spawn.with_shell("firefox " .. AwesomeWM.values.gmailLink)
			AwesomeWM.widgets.pages.dashboard.toggle()
		end,
	},

	{
		name = "outlookLink",
		text = AwesomeWM.values.outlookID,
		test = AwesomeWM.values.outlookID,
		icon = "󰴢",
		activeColor = AwesomeWM.beautiful.blue,
		inactiveColor = AwesomeWM.beautiful.blue,
		onClick = function()
			AwesomeWM.awful.spawn.with_shell("firefox " .. AwesomeWM.values.outlookLink)
			AwesomeWM.widgets.pages.dashboard.toggle()
		end,
	},

	{
		name = "githubLink",
		text = "github.com/" .. AwesomeWM.values.githubName,
		test = AwesomeWM.values.githubName,
		icon = "",
		activeColor = AwesomeWM.beautiful.white,
		inactiveColor = AwesomeWM.beautiful.white,
		onClick = function()
			AwesomeWM.awful.spawn.with_shell("firefox " .. AwesomeWM.values.githubLink)
			AwesomeWM.widgets.pages.dashboard.toggle()
		end,
	},

	-- {
	-- 	name = 'redditLink',
	-- 	text = "reddit.com",
	-- 	test = AwesomeWM.values.redditName,
	-- 	icon = "󰑍",
	-- 	activeColor = AwesomeWM.beautiful.orange,
	-- 	inactiveColor = AwesomeWM.beautiful.orange,
	-- 	onClick = function()
	-- 		AwesomeWM.awful.spawn.with_shell('firefox ' .. AwesomeWM.values.redditLink)
	-- 		AwesomeWM.widgets.pages.dashboard.toggle()
	-- 	end
	-- },

	{
		name = "whatsappLink",
		text = "web.whatsapp.com",
		test = true,
		icon = "󰖣",
		activeColor = AwesomeWM.beautiful.green,
		inactiveColor = AwesomeWM.beautiful.green,
		onClick = function()
			AwesomeWM.awful.spawn.with_shell("firefox https://web.whatsapp.com/")
			AwesomeWM.widgets.pages.dashboard.toggle()
		end,
	},
}

userProfileComponent.right = AwesomeWM.wibox.widget({
	widget = AwesomeWM.wibox.layout.fixed.vertical,
})

for _, options in pairs(userProfileComponent.links) do
	if options.test then
		userProfileComponent[options.name] = helper_sm.makeLink(options.text, options.onClick, {
			icon = options.icon,
			activeColor = options.activeColor,
			inactiveColor = options.inactiveColor,
		})

		userProfileComponent.right:add(userProfileComponent[options.name].main)
	end
end

userProfileComponent.left:set_ratio(2, 0.3)

userProfileComponent.main = AwesomeWM.wibox.widget({
	userProfileComponent.left,
	{
		userProfileComponent.right,
		valign = "center",
		align = "left",
		widget = AwesomeWM.wibox.container.place,
	},
	widget = AwesomeWM.wibox.layout.ratio.horizontal,
})

userProfileComponent.main:set_ratio(2, 0.6)

return userProfileComponent
