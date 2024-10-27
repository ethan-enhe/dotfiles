local preview_config = {
  type = "float",
  relative = "editor",
  border = "rounded",
  title = "Preview",
  title_pos = "center",
  position = { 0, -2 },
  size = { width = 0.3, height = 0.3 },
  zindex = 200,
}

return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = preview_config,
      },
      qf_preview_float = {
        mode = "quickfix",
        preview = preview_config,
      },
    },
  }, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble preview_float toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble preview_float toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qf_preview_float toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
