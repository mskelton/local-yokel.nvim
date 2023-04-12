local config = require("local-yokel.config")

local M = {}

--- @param tbl table
--- @param val any
local function find_index(tbl, val)
	for i, v in ipairs(tbl) do
		if v == val then
			return i
		end
	end
end

local function get_current_file()
	return vim.fn.expand("%:p")
end

--- @param file string
local function get_file_prefix(file)
	local prefix = string.gsub(file, "%..*$", "")
	local postfixes = config.get("relatives.postfixes")

	for _, postfix in pairs(postfixes or {}) do
		prefix = string.gsub(prefix, postfix, "")
	end

	return prefix
end

--- @param prefix string?
local function read_dir(prefix)
	local dir = vim.fn.expand("%:p:h")
	local glob = (prefix or "") .. "*"
	local res = vim.fn.globpath(dir, glob, true, true)

	if prefix == nil then
		return res
	end

	return vim.tbl_filter(function(file)
		return prefix == get_file_prefix(vim.fn.fnamemodify(file, ":t"))
	end, res)
end

--- @param dir table
--- @param index number
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
	local dir = read_dir()
	local index = find_index(dir, get_current_file())
	navigate(dir, index + 1)
end

M.prev = function()
	local dir = read_dir()
	local index = find_index(dir, get_current_file())
	navigate(dir, index - 1)
end

M.next_sibling = function()
	local current_file = vim.fn.expand("%:t")
	local dir = read_dir(get_file_prefix(current_file))
	local index = find_index(dir, get_current_file())
	navigate(dir, index + 1)
end

M.prev_sibling = function()
	local current_file = vim.fn.expand("%:t")
	local dir = read_dir(get_file_prefix(current_file))
	local index = find_index(dir, get_current_file())
	navigate(dir, index - 1)
end

return M
