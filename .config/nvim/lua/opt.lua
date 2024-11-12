-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
-- vim.opt.hlsearch = false

-- disable netrw at the very start of your init.lua required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
vim.opt.updatetime = 200
vim.opt.signcolumn = 'yes'


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

-- vim.opt.makeprg="cmake --build ./build --config Release"
vim.opt.fileencodings = 'utf8,cp936,gb18030,big5'
-- vim.opt.foldenable = true
-- vim.opt.foldmethod = "marker"
vim.opt.termguicolors = true

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = "FiraCode Nerd Font Mono:h11" -- text below applies for VimScript
    vim.g.neovide_transparency = 0.80
    -- vim.g.neovide_window_blurred= true
    -- local function set_ime(args)
    --   if args.event:match("Enter$") then
    --     vim.g.neovide_input_ime = true
    --   else
    --     vim.g.neovide_input_ime = false
    --   end
    -- end
    --
    -- local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })
    --
    -- vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    --   group = ime_input,
    --   pattern = "*",
    --   callback = set_ime
    -- })
    --
    -- vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    --   group = ime_input,
    --   pattern = "[/\\?]",
    --   callback = set_ime
    -- })
end
-- vim.env.GIT_EDITOR = 'nvr -cc split --remote-wait'
