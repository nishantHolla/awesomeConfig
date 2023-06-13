-- Keymap module

local module = {}

module.modkey = 'Mod4'
module.list = {
	['Awesome'] = {
		{
			{module.modkey}, '1',
			function()
				AwesomeWM.functions.restart()
			end,
			'Restart awesome'
		},
		{
			{module.modkey}, '2',
			function()
				AwesomeWM.awful.spawn('rofi -show window')
			end,
			'Show open clients'
		},
		{
			{module.modkey}, 'Escape',
			function()
				AwesomeWM.awful.spawn.with_shell('$XDG_CONFIG_HOME/rofi/scripts/powermenu.sh')
			end,
			'Show powermenu',
		},
	},

	['Brightness keys'] = {
		{
			{}, 'XF86MonBrightnessUp',
			function()
				AwesomeWM.functions.brightness.increase()
			end,
			'Increase brightness',
		},
		{
			{}, 'XF86MonBrightnessDown',
			function()
				AwesomeWM.functions.brightness.decrease()
			end,
			'Decrease brightness',
		}
	},

	['Volume keys'] = {
		{
			{}, 'XF86AudioRaiseVolume',
			function()
				AwesomeWM.functions.volume.increase()
			end,
			'Increase volume',
		},
		{
			{}, 'XF86AudioLowerVolume',
			function()
				AwesomeWM.functions.volume.decrease()
			end,
			'Increase volume'
		},
		{
			{}, 'XF86AudioMute',
			function()
				AwesomeWM.functions.volume.toggle()
			end,
			'Increase volume'
		},
	},

	['Player keys'] = {
		{
			{}, 'XF86AudioPrev',
			function()
				AwesomeWM.functions.player.previous()
			end,
			'Play previous audio'
		},
		{
			{}, 'XF86AudioNext',
			function()
				AwesomeWM.functions.player.next()
			end,
			'Play previous audio'
		},
		{
			{}, 'XF86AudioPlay',
			function()
				AwesomeWM.functions.player.toggle()
			end,
			'Play previous audio'
		},
	},
	
	['Applications'] = {
		{
			{module.modkey}, 'Return',
			function()
				AwesomeWM.awful.spawn(AwesomeWM.values.terminal)
			end,
			'Spawn ' .. AwesomeWM.values.terminal,
		},

		{
			{module.modkey}, "'",
			function()
				AwesomeWM.awful.spawn(AwesomeWM.values.browser)
			end,
			'Spawn ' .. AwesomeWM.values.browser,
		},

		{
			{module.modkey}, 'space',
			function()
				AwesomeWM.awful.spawn('rofi -show drun')
			end,
			'Launcher'
		},
	},

	['Client movement'] = {
		{
			{module.modkey}, 'h',
			function()
				AwesomeWM.awful.client.focus.bydirection('left')
			end,
			'Move focus to left',
		},
		{
			{module.modkey}, 'j',
			function()
				AwesomeWM.awful.client.focus.bydirection('down')
			end,
			'Move focus to bottom',
		},
		{
			{module.modkey}, 'k',
			function()
				AwesomeWM.awful.client.focus.bydirection('up')
			end,
			'Move focus to top',
		},
		{
			{module.modkey}, 'l',
			function()
				AwesomeWM.awful.client.focus.bydirection('right')
			end,
			'Move focus to right',
		},
		{
			{module.modkey}, 'i',
			function()
				AwesomeWM.awful.client.focus.byidx(-1)
			end,
			'Move focus to previous client',
		},
		{
			{module.modkey}, 'o',
			function()
				AwesomeWM.awful.client.focus.byidx(1)
			end,
			'Move focus to next client',
		},
		{
			{module.modkey}, 'Tab',
			function()
				AwesomeWM.awful.client.focus.history.previous()
				if AwesomeWM.client.focus then AwesomeWM.client.focus:raise() end
			end
		},

	},

	['Client swap'] = {
		{
			{module.modkey, 'Shift'}, 'h',
			function()
				AwesomeWM.awful.client.swap.bydirection('left')
			end,
			'Swap client with left',
		},
		{
			{module.modkey, 'Shift'}, 'j',
			function()
				AwesomeWM.awful.client.swap.bydirection('down')
			end,
			'Swap client with bottom',
		},
		{
			{module.modkey, 'Shift'}, 'k',
			function()
				AwesomeWM.awful.client.swap.bydirection('up')
			end,
			'Swap client with top',
		},
		{
			{module.modkey, 'Shift'}, 'l',
			function()
				AwesomeWM.awful.client.swap.bydirection('right')
			end,
			'Swap client with right',
		},
	},

	['Client management'] = {
		{
			{module.modkey}, 'c',
			function()
				AwesomeWM.client.focus:kill()
			end,
			'Close client'
		},
		{
			{module.modkey}, ',',
			function()
				AwesomeWM.functions.toggleClientProperty('floating')
			end,
			'Make client floating'
		},
		{
			{module.modkey}, '.',
			function()
				AwesomeWM.functions.toggleClientProperty('sticky')
			end,
			'Make client sticky'
		},
		{
			{module.modkey}, '/',
			function()
				AwesomeWM.functions.toggleClientProperty('fullscreen')
			end,
			'Make client fullscreen'
		}
	},

	['Tag movement'] = {
		{
			{module.modkey}, 'w',
			function()
				AwesomeWM.functions.moveToTag('previous')
			end,
			'View previous tag'
		},
		{
			{module.modkey}, 'e',
			function()
				AwesomeWM.functions.moveToTag('next')
			end,
			'View next tag'
		}
	},

	['Tag shift'] = {},

	['Tag management'] = {
		{
			{module.modkey}, 'q',
			function()
				AwesomeWM.awful.layout.inc(1)
			end,
			'Cycle tag layout'
		}
	},

}

module.addTagMovementKeymaps = function()
	for _, t in pairs(AwesomeWM.values.tags) do
		table.insert(module.list['Tag movement'], {
			{module.modkey}, t.key,
			function()
				AwesomeWM.functions.moveToTag(t.name)
			end,
			'Move to tag ' .. t.name,
		})
	end
end

module.addTagShiftKeymaps = function()
	for _, t in pairs(AwesomeWM.values.tags) do
		table.insert(module.list['Tag shift'], {
			{module.modkey, 'Shift'}, t.key,
			function()
				local focusedScreen = AwesomeWM.awful.screen.focused()
				local tag = AwesomeWM.awful.tag.find_by_name(focusedScreen, t.name)
				AwesomeWM.client.focus:move_to_tag(tag)
				AwesomeWM.functions.moveToTag(t.name)
			end,
			'Move current client to tag ' .. t.name
		})
	end
end

module.makeKeymap = function(_map, _groupName)
	return AwesomeWM.awful.key(_map[1], _map[2], _map[3], {description=_map[4], group=_groupName})
end

module.initKeymaps = function()
	modkey = module.modkey
	module.addTagMovementKeymaps()
	module.addTagShiftKeymaps()
	
	local keymaps = {}
	for groupName, groupList in pairs(module.list) do
		for _, map in pairs(groupList) do
			keymaps = AwesomeWM.gears.table.join(keymaps, module.makeKeymap(map, groupName))
		end
	end
	AwesomeWM.root.keys(keymaps)
end

return module
