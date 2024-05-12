require "plug"
require "opt"
require "map"


require("bufferline").setup {}
require('Comment').setup()

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}
require("nvim-surround").setup {}
require("nvim-autopairs").setup {}

-- iterate through and require all neovim .lua config files under `./lua` directory
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/plugcfg")) do
  if file:match("%.lua$") then
    require("plugcfg." .. file:sub(1, -5))
  end
end

