return {
  'akinsho/toggleterm.nvim',
  config = function()
    require("toggleterm").setup({
      size = 10,
      open_mapping = "<f12>",
      shade_terminals = false,
      -- direction = "float",
      -- float_opts = {
      --   border = "curved"
      -- }
    })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode", buffer = 0 })
      -- vim.keymap.set('t', 'jj', [[<C-\><C-n>]], { desc = "Exit terminal mode", buffer = 0 })
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Move to left window", buffer = 0 })
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Move to bottom window", buffer = 0 })
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Move to top window", buffer = 0 })
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Move to right window", buffer = 0 })
      vim.keymap.set('t', '<leader>l', [[<nop>]], { desc = "Disable <leader>l in terminal mode", buffer = 0 })
      vim.keymap.set('t', '<leader>h', [[<nop>]], { desc = "Disable <leader>h in terminal mode", buffer = 0 })
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}
