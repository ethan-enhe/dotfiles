return {
  {'nvim-treesitter/nvim-treesitter',
    config=function ()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'c', 'cpp',  'lua', 'python','vimdoc','lua','vim' ,'latex','html'},
        -- ignore_install = { "latex" },

        highlight = { 
          enable = true, 
          disable = { "latex"},
        },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
      -- vim.opt.foldmethod = 'marker'
      -- vim.opt.foldmethod = 'indent'
      -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      -- vim.opt.foldlevel = 99
      -- vim.opt.foldminlines = 10
    end
  }, -- Highlight, edit, and navigate code
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter' } } -- Additional textobjects for treesitter
}
