-- [[ Basic Keymaps ]]
-- maps unrelated to plugins should be in this file
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--
vim.keymap.set('n', '<C-h>', [[<Cmd>wincmd h<CR>]], { silent = true })
vim.keymap.set('n', '<C-j>', [[<Cmd>wincmd j<CR>]], { silent = true })
vim.keymap.set('n', '<C-k>', [[<Cmd>wincmd k<CR>]], { silent = true })
vim.keymap.set('n', '<C-l>', [[<Cmd>wincmd l<CR>]], { silent = true })
-- vim.keymap.set('i', 'jj', "<esc>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>rl', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { silent = true })
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { silent = true })
vim.keymap.set('n', '<leader>s', '<cmd>source %<cr>', { silent = true })
vim.keymap.set('n', '<leader>c', '<cmd>cd %:p:h<cr><cmd>pwd<cr>', { silent = true })

vim.keymap.set('n', '<leader>tt', '<cmd>0 r ~/Documents/mycode/template/other/cf.cpp<cr>', { silent = true })
vim.keymap.set('n', '<leader>tr', ':r ~/Documents/mycode/template/', { silent = true })
vim.keymap.set('n', '0', '^')
vim.keymap.set('x', '0', '^')


-- Buffers Operations
vim.keymap.set('n', '<leader>bd', function()
  local curbufnum = vim.fn.bufnr("%")
  local altbufnum = vim.fn.bufnr("#")
  if vim.fn.buflisted(altbufnum) then
    vim.cmd("buffer #")
  else
    vim.cmd("bnext")
  end

  if vim.fn.bufnr("%") == curbufnum then
    vim.cmd("new")
  end
  if vim.fn.buflisted(curbufnum) then
    vim.cmd("bdelete! " .. curbufnum)
  end
end, { silent = true })
vim.keymap.set('n', '<leader>l', '<cmd>bnext<cr>', { silent = true })
vim.keymap.set('n', '<leader>h', '<cmd>bprevious<cr>', { silent = true })
vim.keymap.set('n', '<leader><cr>', '<cmd>noh<cr>', { silent = true })


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
