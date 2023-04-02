local config = require("local-yokel.config")

local M = {}

--- @param glob string
--- @return table
local function read_dir(glob)
	local dir = vim.fn.expand("%:p:h")
	return vim.fn.globpath(dir, glob, true, true)
end

local function find_index(tbl, val)
	for i, v in ipairs(tbl) do
		if v == val then
			return i
		end
	end
end

local function get_file()
	return vim.fn.expand("%:p")
end

local function get_file_prefix()
	local prefix = string.gsub(vim.fn.expand("%:t"), "%..*$", "")
	local postfixes = config.get("relatives.postfixes")

	for _, postfix in pairs(postfixes or {}) do
		prefix = string.gsub(prefix, postfix, "")
	end

	return prefix
end

local function navigate(dir, index)
	-- No need to navigate when this is the only file
	if #dir < 2 then
		return
	end

	if index > #dir then
		index = 1
	elseif index == 0 then
		index = #dir
	end

	vim.cmd("edit " .. dir[index])
end

M.next = function()
	local dir = read_dir("*")
	local index = find_index(dir, get_file())
	navigate(index + 1)
end

M.prev = function()
	local dir = read_dir("*")
	local index = find_index(dir, get_file())
	navigate(index - 1)
end

M.next_sibling = function()
	local dir = read_dir(get_file_prefix() .. "*")
	local index = find_index(dir, get_file())
	navigate(dir, index + 1)
end

M.prev_sibling = function()
	local dir = read_dir(get_file_prefix() .. "*")
	local index = find_index(dir, get_file())
	navigate(dir, index - 1)
end

return M
