local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Lazy completes,'
  print '       then restart nvim'
  print '=================================='

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- stylua: ignore start
require('lazy').setup({
  {'kylechui/nvim-surround'},
  {'tpope/vim-fugitive'}, -- Git commands in nvim
  { 'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } }, -- Add git related info in the signs columns and popups
  {'nvim-treesitter/nvim-treesitter'}, -- Highlight, edit, and navigate code
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter' } }, -- Additional textobjects for treesitter
  -- {'simrat39/symbols-outline.nvim'},
  {'hedyhli/outline.nvim'},
  {'neovim/nvim-lspconfig'}, -- Collection of configurations for built-in LSP client
  {'williamboman/mason.nvim'}, -- Manage external editor tooling i.e LSP servers
  {'williamboman/mason-lspconfig.nvim'}, -- Automatically install language servers to stdpath
  {'folke/which-key.nvim'},
  { 'hrsh7th/nvim-cmp', dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  } }, -- Autocompletion
  {'numToStr/Comment.nvim'},
  -- {'luozhiya/fittencode.nvim'},
  {'Exafunction/codeium.vim', commit = "289eb724e5d6fab2263e94a1ad6e54afebefafb2"},
  { 'L3MON4D3/LuaSnip', dependencies = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets'  } }, -- Snippet Engine and Snippet Expansion

  {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    -- ft = { "tex" }, -- 只在 LaTeX 文件类型加载插件
    config = function()
      require("luasnip-latex-snippets").setup({
        use_treesitter = false, -- whether to use treesitter to determine if cursor is in math mode; if false, vimtex is used
        allow_on_markdown = true, -- whether to add snippets to markdown filetype
      })
    end,
  },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {'windwp/nvim-autopairs'},
  {'lervag/vimtex'},
  {'mjlbach/onedark.nvim'}, -- Theme inspired by Atom
  {'sainnhe/edge'},
  {'nvim-lualine/lualine.nvim'},
  { 'akinsho/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
  -- { 'Theyashsawarkar/bufferline.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
  { 'nvim-tree/nvim-tree.lua', dependencies = 'nvim-tree/nvim-web-devicons' },
  {'lukas-reineke/indent-blankline.nvim'}, -- Add indentation guides even on blank lines
  {'tpope/vim-sleuth'}, -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- {
  --   'glacambre/firenvim',
  --   build = function() vim.fn['firenvim#install'](0) end
  -- },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable("make") == 1 end },

  { "akinsho/toggleterm.nvim" },
})
