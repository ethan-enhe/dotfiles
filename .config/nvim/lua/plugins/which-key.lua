return {
  'folke/which-key.nvim',
  config = function()
    require("which-key").setup {
    }
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end
}
