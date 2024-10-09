return {
  {
    'h-hg/fcitx.nvim',
    cond = vim.fn.executable('fcitx5-remote') == 1,
  },
  {'kylechui/nvim-surround'},
  {'tpope/vim-fugitive'}, -- Git commands in nvim
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } }, -- Add git related info in the signs columns and popups
  {'nvim-treesitter/nvim-treesitter'}, -- Highlight, edit, and navigate code
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter' } }, -- Additional textobjects for treesitter
  {'hedyhli/outline.nvim'},
  { 'hrsh7th/nvim-cmp', dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip' ,
  } }, -- Autocompletion
  {'numToStr/Comment.nvim'},
  -- {'luozhiya/fittencode.nvim'},
  -- {'Exafunction/codeium.vim'},
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
  },

  {
    'iurimateus/luasnip-latex-snippets.nvim',
    dependencies = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
    -- ft = { 'tex' }, -- 只在 LaTeX 文件类型加载插件
    config = function()
      require('luasnip-latex-snippets').setup({
        use_treesitter = false, -- whether to use treesitter to determine if cursor is in math mode; if false, vimtex is used
        allow_on_markdown = true, -- whether to add snippets to markdown filetype
      })
    end,
  },
  -- install without yarn or npm
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function() vim.fn['mkdp#util#install']() end,
  },
  {'windwp/nvim-autopairs'},
  {'mjlbach/onedark.nvim'}, -- Theme inspired by Atom
  {'sainnhe/edge'},
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {'nvim-lualine/lualine.nvim'},
  { 'nvim-tree/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons' },
  {'lukas-reineke/indent-blankline.nvim'}, -- Add indentation guides even on blank lines
  {'tpope/vim-sleuth'}, -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable('make') == 1 end },
  { 'akinsho/toggleterm.nvim' },
  {
    'OXY2DEV/markview.nvim',
    lazy = false,      -- Recommended
    -- ft = 'markdown' -- If you decide to lazy-load anyway

    dependencies = {
      -- You will not need this if you installed the
      -- parsers manually
      -- Or if the parsers are in your $RUNTIMEPATH
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    }
  },
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },
}
