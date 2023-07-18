
local table_sm = {}

table_sm.shallowCopy = function(_table)
	if type(_table) ~= "table" then return end

	local _t = {}
	for i, v in pairs(_table) do
		_t[i] = v
	end

	return _t
end

return table_sm
