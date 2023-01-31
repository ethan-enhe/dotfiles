-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://hub.nuaa.cf/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(
  { function(use)
--use "brglng/vim-im-select"
    use 'wbthomason/packer.nvim' -- Package manager
    use 'kylechui/nvim-surround' -- Git commands in nvim
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } } -- Additional textobjects for treesitter
    use 'simrat39/symbols-outline.nvim'
    use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    use 'williamboman/mason.nvim' -- Manage external editor tooling i.e LSP servers
    use 'williamboman/mason-lspconfig.nvim' -- Automatically install language servers to stdpath
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } } -- Autocompletion
    use { 'L3MON4D3/LuaSnip', requires = {
      'saadparwaiz1/cmp_luasnip',
      -- 'honza/vim-snippets',
      'rafamadriz/friendly-snippets',
    } } -- Snippet Engine and Snippet Expansion
    use {
      "iurimateus/luasnip-latex-snippets.nvim",
      -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
      -- using treesitter.
      requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
      config = function()
        require 'luasnip-latex-snippets'.setup({ use_treesitter = true })
        -- or setup({ use_treesitter = true })
      end,
      ft = "tex",
    }

    use 'windwp/nvim-autopairs'

    use 'lervag/vimtex'
    use 'kyazdani42/nvim-web-devicons'
    use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
    use 'sainnhe/edge'
    use 'nvim-lualine/lualine.nvim'
    -- use 'akinsho/bufferline.nvim'
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    end }
    if is_bootstrap then
      require('packer').sync()
    end
  end,
    config = {
      max_jobs = 16,
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'single' })
        end
      },
      git = {
        clone_timeout = 60, -- Timeout, in seconds, for git clones
        default_url_format = 'https://hub.nuaa.cf/%s' -- Lua format string used for "aaa/bbb" style plugins
      },
    },
  }
)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.



if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
