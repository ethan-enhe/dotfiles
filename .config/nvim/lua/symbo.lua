require("symbols-outline").setup {
  position = 'left'
}
vim.keymap.set("n", "<f10>", function()
  print "Toggle Outline"
  vim.cmd "SymbolsOutline"
end, { silent = true })
