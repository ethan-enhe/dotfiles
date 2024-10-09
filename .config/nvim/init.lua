require "opt"
require "map"
require "plug"

-- iterate through and require all .lua plug config files under `./lua/plugcfg` directory
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugcfg")) do
  if file:match("%.lua$") then
    -- catch any error
    local ok, err = pcall(require, "plugcfg." .. file:sub(1, -5))
    if not ok then
      print("Error in plugcfg." .. file:sub(1, -5) .. ": " .. err)
    end
  end
end


