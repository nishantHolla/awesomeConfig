-- Keymap module

local module = {}

module.modkey = 'Mod4'
module.list = {
	['Awesome'] = {
		{
			{module.modkey}, '1',
			function()
				AwesomeWM.awesome.restart()
			end,
			'Restart awesome'
		}
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
		}
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

	['Tag shift'] = {}

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
