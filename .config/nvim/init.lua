require "opt"
require "map"
require "plug"

-- iterate through and require all .lua plug config files under `./lua/user` directory
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/user")) do
  if file:match("%.lua$") then
    -- catch any error
    local ok, err = pcall(require, "user." .. file:sub(1, -5))
    if not ok then
      print("Error in user." .. file:sub(1, -5) .. ": " .. err)
    end
  end
end


