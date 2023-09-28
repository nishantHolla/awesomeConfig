local keymaps_m = {}

keymaps_m.modkey = "Mod4"
keymaps_m.list = {
	["Awesome"] = {
		{
			{ keymaps_m.modkey },
			"1",
			function()
				AwesomeWM.functions.restart()
			end,
			"Restart awesome",
		},
		{
			{ keymaps_m.modkey },
			"2",
			function()
				AwesomeWM.functions.spawn("rofi -show window")
			end,
			"Show open clients",
		},
		{
			{ keymaps_m.modkey },
			"3",
			function()
				AwesomeWM.functions.spawn("betterlockscreen -l")
			end,
			"Lock the computer",
		},
		{
			{ keymaps_m.modkey, "Shift" },
			"3",
			function()
				AwesomeWM.functions.spawn_with_shell("sleep 1; xset dpms force off; betterlockscreen -l")
			end,
			"Turn off screen",
		},
		{
			{ keymaps_m.modkey },
			"Escape",
			function()
				AwesomeWM.functions.spawn_with_shell("$XDG_CONFIG_HOME/rofi/scripts/powermenu.sh")
			end,
			"Show powermenu",
		},
		{
			{ keymaps_m.modkey },
			"`",
			function()
				AwesomeWM.widgets.pages.dashboard.toggle()
			end,
			"Show dashboard",
		},
	},

	["Brightness keys"] = {
		{
			{},
			"XF86MonBrightnessUp",
			function()
				AwesomeWM.functions.brightness.increase()
			end,
			"Increase brightness",
		},
		{
			{},
			"XF86MonBrightnessDown",
			function()
				AwesomeWM.functions.brightness.decrease()
			end,
			"Decrease brightness",
		},
	},

	["Volume keys"] = {
		{
			{},
			"XF86AudioRaiseVolume",
			function()
				AwesomeWM.functions.volume.increase()
			end,
			"Increase volume",
		},
		{
			{},
			"XF86AudioLowerVolume",
			function()
				AwesomeWM.functions.volume.decrease()
			end,
			"Increase volume",
		},
		{
			{},
			"XF86AudioMute",
			function()
				AwesomeWM.functions.volume.toggle()
			end,
			"Increase volume",
		},
	},

	["Player keys"] = {
		{
			{},
			"XF86AudioPrev",
			function()
				AwesomeWM.functions.player.previous()
			end,
			"Play previous audio",
		},
		{
			{},
			"XF86AudioNext",
			function()
				AwesomeWM.functions.player.next()
			end,
			"Play previous audio",
		},
		{
			{},
			"XF86AudioPlay",
			function()
				AwesomeWM.functions.player.toggle()
			end,
			"Play previous audio",
		},
	},

	["Applications"] = {
		{
			{ keymaps_m.modkey },
			"Return",
			function()
				AwesomeWM.functions.spawn(AwesomeWM.values.terminal)
			end,
			"Spawn " .. AwesomeWM.values.terminal,
		},

		{
			{ keymaps_m.modkey },
			"'",
			function()
				AwesomeWM.functions.spawn(AwesomeWM.values.browser)
			end,
			"Spawn " .. AwesomeWM.values.browser,
		},

		{
			{ keymaps_m.modkey },
			";",
			function()
				AwesomeWM.functions.spawn(AwesomeWM.values.fileManager)
			end,
			"Spawn " .. AwesomeWM.values.fileManager,
		},

		{
			{ keymaps_m.modkey },
			"space",
			function()
				AwesomeWM.functions.spawn_with_shell("$XDG_CONFIG_HOME/rofi/scripts/open.sh")
			end,
			"Launcher",
		},
		{
			{ keymaps_m.modkey },
			"Print",
			function()
				AwesomeWM.functions.spawn("flameshot gui")
			end,
			"Screenshot",
		},
	},

	["Client movement"] = {
		{
			{ keymaps_m.modkey },
			"h",
			function()
				AwesomeWM.awful.client.focus.bydirection("left")
			end,
			"Move focus to left",
		},
		{
			{ keymaps_m.modkey },
			"j",
			function()
				AwesomeWM.awful.client.focus.bydirection("down")
			end,
			"Move focus to bottom",
		},
		{
			{ keymaps_m.modkey },
			"k",
			function()
				AwesomeWM.awful.client.focus.bydirection("up")
			end,
			"Move focus to top",
		},
		{
			{ keymaps_m.modkey },
			"l",
			function()
				AwesomeWM.awful.client.focus.bydirection("right")
			end,
			"Move focus to right",
		},
		{
			{ keymaps_m.modkey },
			"i",
			function()
				AwesomeWM.awful.client.focus.byidx(-1)
			end,
			"Move focus to previous client",
		},
		{
			{ keymaps_m.modkey },
			"o",
			function()
				AwesomeWM.awful.client.focus.byidx(1)
			end,
			"Move focus to next client",
		},
		{
			{ keymaps_m.modkey },
			"Tab",
			function()
				AwesomeWM.awful.client.focus.history.previous()
				if AwesomeWM.client.focus then
					AwesomeWM.client.focus:raise()
				end
			end,
		},
	},

	["Client swap"] = {
		{
			{ keymaps_m.modkey, "Shift" },
			"h",
			function()
				AwesomeWM.awful.client.swap.bydirection("left")
			end,
			"Swap client with left",
		},
		{
			{ keymaps_m.modkey, "Shift" },
			"j",
			function()
				AwesomeWM.awful.client.swap.bydirection("down")
			end,
			"Swap client with bottom",
		},
		{
			{ keymaps_m.modkey, "Shift" },
			"k",
			function()
				AwesomeWM.awful.client.swap.bydirection("up")
			end,
			"Swap client with top",
		},
		{
			{ keymaps_m.modkey, "Shift" },
			"l",
			function()
				AwesomeWM.awful.client.swap.bydirection("right")
			end,
			"Swap client with right",
		},
	},

	["Client management"] = {
		{
			{ keymaps_m.modkey },
			"c",
			function()
				if AwesomeWM.client.focus then
					if AwesomeWM.client.focus.notToKill then
						return
					end

					AwesomeWM.client.focus:kill()
				end
			end,
			"Close client",
		},
		{
			{ keymaps_m.modkey },
			"7",
			function()
				AwesomeWM.functions.clients.toggleClientProperty("notToKill")
			end,
			"Prevent client from closing",
		},
		{
			{ keymaps_m.modkey },
			"8",
			function()
				AwesomeWM.functions.clients.toggleClientProperty("floating")
			end,
			"Make client floating",
		},
		{
			{ keymaps_m.modkey },
			"9",
			function()
				AwesomeWM.functions.clients.toggleClientProperty("sticky")
			end,
			"Make client sticky",
		},
		{
			{ keymaps_m.modkey },
			"0",
			function()
				AwesomeWM.functions.clients.toggleClientProperty("fullscreen")
			end,
			"Make client fullscreen",
		},
	},

	["Tag movement"] = {
		{
			{ keymaps_m.modkey },
			"w",
			function()
				AwesomeWM.functions.tags.moveToTag("previous")
			end,
			"View previous tag",
		},
		{
			{ keymaps_m.modkey },
			"e",
			function()
				AwesomeWM.functions.tags.moveToTag("next")
			end,
			"View next tag",
		},
	},

	["Tag shift"] = {},

	["Tag management"] = {
		{
			{ keymaps_m.modkey },
			"Tab",
			function()
				AwesomeWM.functions.tags.cycleLayout(1)
			end,
			"Cycle tag layout",
		},

		{
			{ keymaps_m.modkey, "Shift" },
			"Tab",
			function()
				AwesomeWM.functions.tags.cycleLayout(-1)
			end,
			"Cycle tag layout reverse",
		},
	},
}

keymaps_m.addTagMovementKeymaps = function()
	for _, t in pairs(AwesomeWM.values.tags) do
		table.insert(keymaps_m.list["Tag movement"], {
			{ keymaps_m.modkey },
			t.key,
			function()
				AwesomeWM.functions.tags.moveToTag(t.name)
			end,
			"Move to tag " .. t.name,
		})
	end
end

keymaps_m.addTagShiftKeymaps = function()
	for _, t in pairs(AwesomeWM.values.tags) do
		table.insert(keymaps_m.list["Tag shift"], {
			{ keymaps_m.modkey, "Shift" },
			t.key,
			function()
				local focusedScreen = AwesomeWM.awful.screen.focused()
				local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, t.name)
				if AwesomeWM.client.focus == nil then
					return
				end
				AwesomeWM.client.focus:move_to_tag(tag)
				AwesomeWM.functions.tags.moveToTag(t.name)
			end,
			"Move current client to tag " .. t.name,
		})
	end
end

keymaps_m.getClientButtons = function()
	local clientButtons = AwesomeWM.gears.table.join(
		AwesomeWM.awful.button({}, 1, function(_client)
			_client:emit_signal("request::activate", "mouse_click", { raise = true })
		end),
		AwesomeWM.awful.button({ keymaps_m.modkey }, 1, function(_client)
			_client:emit_signal("request::activate", "mouse_click", { raise = true })
			AwesomeWM.awful.mouse.client.move(_client)
		end),
		AwesomeWM.awful.button({ keymaps_m.modkey }, 3, function(_client)
			_client:emit_signal("request::activate", "mouse_click", { raise = true })
			AwesomeWM.awful.mouse.client.resize(_client)
		end),
		AwesomeWM.awful.button({ keymaps_m.modkey }, 2, function(_client)
			if _client then
				_client:kill()
			end
		end)
	)

	return clientButtons
end

keymaps_m.makeKeymap = function(_map, _groupName)
	return AwesomeWM.awful.key(_map[1], _map[2], _map[3], { description = _map[4], group = _groupName })
end

keymaps_m.initKeymaps = function()
	modkey = keymaps_m.modkey
	keymaps_m.addTagMovementKeymaps()
	keymaps_m.addTagShiftKeymaps()

	local keymaps = {}
	for groupName, groupList in pairs(keymaps_m.list) do
		for _, map in pairs(groupList) do
			keymaps = AwesomeWM.gears.table.join(keymaps, keymaps_m.makeKeymap(map, groupName))
		end
	end
	AwesomeWM.root.keys(keymaps)
end

return keymaps_m
