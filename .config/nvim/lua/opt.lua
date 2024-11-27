-- [[ Setting options ]]
-- See `:help vim.o`

-- Disable netrw at the very start of your init.lua required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.laststatus = 3
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- Enable mouse mode
vim.opt.mouse = "a"

-- Enable break indent
vim.opt.breakindent = true
vim.opt.linebreak = true -- Wrap lines at convenient points

-- Save undo history
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false -- Don't wrap lines

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
vim.opt.smoothscroll = true
-- vim.opt.splitbelow = true -- Put new windows below current
-- vim.opt.splitright = true -- Put new windows right of current

if vim.g.neovide then
	-- Settings specific to Neovide
	vim.o.guifont = "FiraCode Nerd Font Mono:h11"
	vim.g.neovide_transparency = 0.80
end
