require "opt"
require "plug"
require "map"



-- iterate through and require all .lua plug config files under `./lua/plugcfg` directory
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugcfg")) do
  if file:match("%.lua$") then
    require("plugcfg." .. file:sub(1, -5))
  end
end

