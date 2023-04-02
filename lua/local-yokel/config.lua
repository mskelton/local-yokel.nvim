local M = {}

M._config = {
	relatives = {
		postfixes = {},
	},
}

--- @param config table
M.load = function(config)
	M._config = vim.tbl_deep_extend("force", M._config, config)
end

M.get = function(key)
	local res = M._config

	for _, k in pairs(vim.split(key, "%.", {})) do
		res = res[k]

		if res == nil then
			return nil
		end
	end

	return res
end

return M
