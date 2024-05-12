require "plug"
require "opt"
require "map"


require("bufferline").setup {}
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
--require('ibl').setup {
-- -- indent={char = '┊'},
-- -- show_trailing_blankline_indent = false,
--}
--
-- Gitsigns
-- See `:help gitsigns.txt`
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

require "vtex"
require "ims"
require "symbo"
require "tele"
require "treesitter"
require "lsp"
require "compl"
require "term"
require "snip"
require "text"
require "lual"

