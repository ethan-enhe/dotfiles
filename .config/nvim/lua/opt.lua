-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
-- vim.opt.hlsearch = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = 'yes'

-- Set colorscheme
vim.opt.termguicolors = true
vim.g.edge_style = 'aura'
vim.g.edge_better_performance = 1
vim.cmd [[colorscheme edge]]

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.scrolloff = 7
vim.opt.clipboard:append("unnamedplus")
vim.opt.expandtab = true
vim.opt.backspace = "indent,eol,start"
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.winaltkeys = "no"
-- vim.opt.foldenable = true
-- vim.opt.foldmethod = "marker"
