local function log_out(data, path)
	path = path or "/tmp/nvim.log"
	local file = io.open(path, "a+")
	if not file then return end

	file:write(data)
	file:close()
end

return log_out
