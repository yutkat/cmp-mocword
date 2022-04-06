local Job = require("plenary.job")
local M = {}

local function candidates(input, callback)
	if input == "" then
		return
	end
	Job
		:new({
			command = "mocword",
			args = { "-q", input },
			on_exit = function(job, return_val)
				local result = job:result()
				local items = vim.tbl_map(function(w)
					return {
						label = w,
					}
				end, result)
				callback({ items = items, isIncomplete = true })
			end,
		})
		:start()
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
	candidates(input, callback)
end

return M
