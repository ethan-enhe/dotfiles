-- Function to safely require a module and handle errors
local function safe_require(module)
	local ok, err = pcall(require, module)
	if not ok then
		print("Error in " .. module .. ": " .. err)
	end
end

-- Load core configurations
safe_require("opt")
safe_require("map")
safe_require("plug")
safe_require("autocmd")
