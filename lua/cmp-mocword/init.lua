local M = {}

local function split(src, sep)
	local result, i = {}, 1
	while true do
		local a, b = src:find(sep)
		if not a then
			break
		end
		local candidat = src:sub(1, a - 1)
		if candidat ~= "" then
			result[i] = candidat
		end
		i = i + 1
		src = src:sub(b + 1)
	end
	if src ~= "" then
		result[i] = src
	end
	return result
end

local function candidates(input)
	local command = "mocword -q " .. '"' .. input .. '"'
	local raw_output = vim.fn.system(command)
	local words = split(raw_output, "\n")
	local items = vim.tbl_map(function(w)
		return {
			label = w,
		}
	end, words)
	return { items = items, isIncomplete = true }
end

function M.new()
	return setmetatable({}, { __index = M })
end

M.get_trigger_characters = function()
	return { " " }
end

M.get_keyword_pattern = function()
	return [[\w\+]]
end

function M.is_available()
	return vim.fn.executable("mocword") == 1
end

function M.complete(self, request, callback)
	local input = request.context.cursor_before_line
	callback(candidates(input))
end

return M
