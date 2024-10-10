return {{ 'catppuccin/nvim', name = 'catppuccin', priority = 1000,config=function()
  vim.cmd.colorscheme "catppuccin"
end },
  {'mjlbach/onedark.nvim'}, -- Theme inspired by Atom
  {'sainnhe/edge'},
}

