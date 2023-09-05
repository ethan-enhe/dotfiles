local ls = require("luasnip")
ls.config.set_config({
  history = true, -- keep around last snippet local to jump back
  enable_autosnippets = true,
  store_selection_keys = "<Tab>",
  updateevents = "TextChanged,TextChangedI",
})
require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip/loaders/from_snipmate").lazy_load()

ls.filetype_extend("all", { "_" })

local snippets_folder = vim.fn.stdpath "config" .. "/lua/snips/"
require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
