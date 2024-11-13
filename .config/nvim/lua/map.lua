-- [[ Basic Keymaps ]]
-- Maps unrelated to plugins should be in this file

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Keymaps for better default experience
-- Disable space key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<Cmd>wincmd h<CR>', { silent = true, desc = "Move to left window" })
vim.keymap.set('n', '<C-j>', '<Cmd>wincmd j<CR>', { silent = true, desc = "Move to bottom window" })
vim.keymap.set('n', '<C-k>', '<Cmd>wincmd k<CR>', { silent = true, desc = "Move to top window" })
vim.keymap.set('n', '<C-l>', '<Cmd>wincmd l<CR>', { silent = true, desc = "Move to right window" })

-- Toggle relative line numbers
vim.keymap.set('n', '<leader>rl', function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { silent = true, desc = "Toggle relative line numbers" })

-- Save and source files
vim.keymap.set('n', '<leader>w', '<cmd>w!<cr>', { silent = true, desc = "Save file" })
vim.keymap.set('n', '<leader>s', '<cmd>source %<cr>', { silent = true, desc = "Source current file" })

-- Change directory to the current file's directory and print the working directory
vim.keymap.set('n', '<leader>cd', function()
    local cwd = vim.fn.expand("%:p:h")
    vim.cmd("cd " .. cwd)
    print("Changed directory to: " .. cwd)
end, { silent = true, desc = "Change to file's directory and print working directory" })
vim.keymap.set('n', '<leader>yd', function()
    local cwd = vim.fn.expand("%:p:h")
    vim.fn.setreg('+', cwd)
    print('Current file directory yanked: ' .. cwd)
end, { silent = true, desc = "Yank current file directory" })
vim.keymap.set('n', '<leader>yf', function()
    local full_fn = vim.fn.expand("%:p")
    vim.fn.setreg('+', full_fn)
    print('Current file name yanked: ' .. full_fn)
end, { silent = true, desc = "Yank current file name (with full path)" })

-- Edit the Neovim configuration file
vim.keymap.set('n', '<leader>cf', '<cmd>e $MYVIMRC<cr><cmd>cd %:p:h<cr>',
    { silent = true, desc = "Edit Neovim configuration file" })

-- Insert template code
vim.keymap.set('n', '<leader>tt', '<cmd>0 r ~/Documents/mycode/template/other/cf.cpp<cr>',
    { silent = true, desc = "Insert template code" })
vim.keymap.set('n', '<leader>tr', ':r ~/Documents/mycode/template/',
    { silent = true, desc = "Insert template code from directory" })

-- Remap 0 to go to the first non-blank character of the line
vim.keymap.set('n', '0', '^', { desc = "Go to first non-blank character of the line" })
vim.keymap.set('x', '0', '^', { desc = "Go to first non-blank character of the line" })

-- Buffer operations
vim.keymap.set('n', '<leader>bd', function()
    local current_buffer = vim.fn.bufnr("%")
    local alternate_buffer = vim.fn.bufnr("#")

    if vim.fn.buflisted(alternate_buffer) then
        vim.cmd("buffer #")
    else
        vim.cmd("bnext")
    end

    if vim.fn.bufnr("%") == current_buffer then
        vim.cmd("new")
    end

    if vim.fn.buflisted(current_buffer) then
        vim.cmd("bdelete! " .. current_buffer)
    end
end, { silent = true, desc = "Delete current buffer" })

vim.keymap.set('n', '<leader>l', '<cmd>bnext<cr>', { silent = true, desc = "Go to next buffer" })
vim.keymap.set('n', '<leader>h', '<cmd>bprevious<cr>', { silent = true, desc = "Go to previous buffer" })

-- Clear search highlighting
vim.keymap.set('n', '<leader><cr>', '<cmd>noh<cr>', { silent = true, desc = "Clear search highlighting" })

-- [[ Highlight on yank ]]
-- Highlight text on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
