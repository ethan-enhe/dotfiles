-- [[ Setting options ]]
-- See `:help vim.o`

-- Disable netrw at the very start of your init.lua required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"

-- Decrease mapped sequence wait time for which-key popup
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- Set tab and indentation options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 10
vim.opt.clipboard:append("unnamedplus")
vim.opt.expandtab = true
vim.opt.backspace = "indent,eol,start"
vim.opt.whichwrap:append("<,>,h,l")
vim.opt.winaltkeys = "no"

-- Set file encodings
vim.opt.fileencodings = "utf8,cp936,gb18030,big5"

-- Enable folding
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"

-- Enable terminal GUI colors
vim.opt.termguicolors = true

if vim.g.neovide then
	-- Settings specific to Neovide
	vim.o.guifont = "FiraCode Nerd Font Mono:h11"
	vim.g.neovide_transparency = 0.80
end
