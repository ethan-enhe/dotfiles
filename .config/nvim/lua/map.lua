-- [[ Basic Keymaps ]]
-- Maps unrelated to plugins should be in this file
local utils=require("utils")

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General Keymaps {{{
-- Disable space key
utils.map({ "n", "v" }, "<Space>", "<nop>", { silent = true })

-- Remap for dealing with word wrap
utils.map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
utils.map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
utils.map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
utils.map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Toggle relative line numbers
utils.map("n", "<leader>rl", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { silent = true, desc = "Toggle relative line numbers" })

-- Save and source files
utils.map("n", "<leader>w", "<cmd>w!<cr>", { silent = true, desc = "Save file" })
utils.map("n", "<leader>s", "<cmd>source %<cr>", { silent = true, desc = "Source current file" })

-- Change directory to the current file's directory and print the working directory
utils.map("n", "<leader>cd", function()
	local cwd = vim.fn.expand("%:p:h")
	vim.cmd("cd " .. cwd)
	print("Changed directory to: " .. cwd)
end, { silent = true, desc = "Change to file's directory and print working directory" })

-- Yank current file directory
utils.map("n", "<leader>yd", function()
	local cwd = vim.fn.expand("%:p:h")
	vim.fn.setreg("+", cwd)
	print("Current file directory yanked: " .. cwd)
end, { silent = true, desc = "Yank current file directory" })

-- Yank current file name (with full path)
utils.map("n", "<leader>yf", function()
	local full_fn = vim.fn.expand("%:p")
	vim.fn.setreg("+", full_fn)
	print("Current file name yanked: " .. full_fn)
end, { silent = true, desc = "Yank current file name (with full path)" })

utils.map("n", "<leader>bl", function()
	vim.cmd("%s/\\v(\\[{}])/\\\\\\1/gc")
	vim.cmd("%s/|/\\|/gc")
end, { silent = true, desc = "Escape special characters in buffer" })

-- Edit the Neovim configuration file
utils.map(
	"n",
	"<leader>cf",
	"<cmd>e $MYVIMRC<cr><cmd>cd %:p:h<cr>",
	{ silent = true, desc = "Edit Neovim configuration file" }
)

-- Insert template code
utils.map(
	"n",
	"<leader>tt",
	"<cmd>0 r ~/Documents/mycode/template/other/cf.cpp<cr>",
	{ silent = true, desc = "Insert template code" }
)
utils.map(
	"n",
	"<leader>tr",
	":r ~/Documents/mycode/template/",
	{ silent = true, desc = "Insert template code from directory" }
)

-- Remap 0 to go to the first non-blank character of the line
utils.map("n", "0", "^", { desc = "Go to first non-blank character of the line" })
utils.map("x", "0", "^", { desc = "Go to first non-blank character of the line" })

-- Clear search highlighting
utils.map({ "i", "n", "v" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Saner behavior of n and N
utils.map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
utils.map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
utils.map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
utils.map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
utils.map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
utils.map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
utils.map("i", ",", ",<c-g>u")
utils.map("i", ".", ".<c-g>u")
utils.map("i", ";", ";<c-g>u")

-- Better indenting
utils.map("v", "<", "<gv")
utils.map("v", ">", ">gv")
-- }}}

-- Window Management {{{
-- Move to window using the <ctrl> hjkl keys
utils.map({ "n", "v" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
utils.map({ "n", "v" }, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
utils.map({ "n", "v" }, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
utils.map({ "n", "v" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
utils.map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
utils.map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
utils.map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
utils.map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- }}}

-- Buffer Operations {{{
utils.map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
utils.map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
utils.map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

utils.map("n", "<leader>l", "<cmd>bnext<cr>", { silent = true, desc = "Go to next buffer" })
utils.map("n", "<leader>h", "<cmd>bprevious<cr>", { silent = true, desc = "Go to previous buffer" })
-- }}}

-- Line Movement {{{
utils.map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
utils.map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
utils.map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
utils.map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
utils.map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
utils.map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
-- }}}

-- Quickfix and Location List {{{
utils.map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
utils.map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Diagnostic keymaps
utils.map("n", "[g", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })
utils.map("n", "]g", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })
-- }}}
