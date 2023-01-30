---@diagnostic disable: param-type-mismatch

local M = {}

local function resolve(arg)
	-- Auto-add the trailing slash if the argument is a relative path
	if arg.sub(arg, -1) == "." then
		arg = arg .. "/"
	end

	local head = vim.fn.fnamemodify(arg, ":h")
	local name = vim.fn.fnamemodify(arg, ":t")
	local dir = vim.fn.simplify(vim.fn.expand("%:p:h") .. "/" .. head)

	return dir, name, head
end

M.setup = function()
	-- Create new file in current directory
	vim.api.nvim_create_user_command("E", function(opts)
		local dir, name = resolve(opts.args)
		vim.cmd.edit(dir .. "/" .. name)
	end, {
		nargs = 1,
		desc = "Edit file relative to the current buffer.",
		complete = function(arg)
			local dir, name, head = resolve(arg)
			local matches = vim.fn.globpath(dir, name .. "*", true, true)

			return vim.tbl_map(function(path)
				local value = head .. "/" .. path.sub(path, dir:len() + 2)
				return string.gsub(value, "^./", "")
			end, matches)
		end,
	})
end

return M
