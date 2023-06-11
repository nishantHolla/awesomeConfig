-- Keymap module

local module = {}

module.modkey = 'Mod4'
module.list = {
	
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

	['Tag movement'] = {}

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

module.makeKeymap = function(_map, _groupName)
	return AwesomeWM.awful.key(_map[1], _map[2], _map[3], {description=_map[4], group=_groupName})
end

module.initKeymaps = function()
	modkey = module.modkey
	module.addTagMovementKeymaps()
	
	local keymaps = {}
	for groupName, groupList in pairs(module.list) do
		for _, map in pairs(groupList) do
			keymaps = AwesomeWM.gears.table.join(keymaps, module.makeKeymap(map, groupName))
		end
	end
	AwesomeWM.root.keys(keymaps)
end

return module
