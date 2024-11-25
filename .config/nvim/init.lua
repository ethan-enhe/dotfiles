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


-- Get the path to the user configuration directory
-- local user_config_path = vim.fn.stdpath("config") .. "/lua/user"

-- Iterate through all .lua files in the user configuration directory
-- local function load_user_configs(path)
-- 	for _, file in ipairs(vim.fn.readdir(path)) do
-- 		if file:match("%.lua$") then
-- 			local module_name = "user." .. file:sub(1, -5)
-- 			safe_require(module_name)
-- 		end
-- 	end
-- end

-- Load user configurations
-- load_user_configs(user_config_path)
