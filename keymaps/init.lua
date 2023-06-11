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
	}

}

module.makeKeymap = function(_map, _groupName)
	return AwesomeWM.awful.key(_map[1], _map[2], _map[3], {description=_map[4], group=_groupName})
end

module.initKeymaps = function()
	modkey = module.modkey
	
	local keymaps = {}
	for groupName, groupList in pairs(module.list) do
		for _, map in pairs(groupList) do
			keymaps = AwesomeWM.gears.table.join(keymaps, module.makeKeymap(map, groupName))
		end
	end
	AwesomeWM.root.keys(keymaps)
end

return module
