-- [[ Basic Keymaps ]]
-- Maps unrelated to plugins should be in this file

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- General Keymaps {{{
-- Disable space key
map({ "n", "v" }, "<Space>", "<nop>", { silent = true })

-- Remap for dealing with word wrap
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Toggle relative line numbers
map("n", "<leader>rl", function()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { silent = true, desc = "Toggle relative line numbers" })

-- Save and source files
map("n", "<leader>w", "<cmd>w!<cr>", { silent = true, desc = "Save file" })
map("n", "<leader>s", "<cmd>source %<cr>", { silent = true, desc = "Source current file" })

-- Change directory to the current file's directory and print the working directory
map("n", "<leader>cd", function()
	local cwd = vim.fn.expand("%:p:h")
	vim.cmd("cd " .. cwd)
	print("Changed directory to: " .. cwd)
end, { silent = true, desc = "Change to file's directory and print working directory" })

-- Yank current file directory
map("n", "<leader>yd", function()
	local cwd = vim.fn.expand("%:p:h")
	vim.fn.setreg("+", cwd)
	print("Current file directory yanked: " .. cwd)
end, { silent = true, desc = "Yank current file directory" })

-- Yank current file name (with full path)
map("n", "<leader>yf", function()
	local full_fn = vim.fn.expand("%:p")
	vim.fn.setreg("+", full_fn)
	print("Current file name yanked: " .. full_fn)
end, { silent = true, desc = "Yank current file name (with full path)" })

-- Edit the Neovim configuration file
map(
	"n",
	"<leader>cf",
	"<cmd>e $MYVIMRC<cr><cmd>cd %:p:h<cr>",
	{ silent = true, desc = "Edit Neovim configuration file" }
)

-- Insert template code
map(
	"n",
	"<leader>tt",
	"<cmd>0 r ~/Documents/mycode/template/other/cf.cpp<cr>",
	{ silent = true, desc = "Insert template code" }
)
map(
	"n",
	"<leader>tr",
	":r ~/Documents/mycode/template/",
	{ silent = true, desc = "Insert template code from directory" }
)

-- Remap 0 to go to the first non-blank character of the line
map("n", "0", "^", { desc = "Go to first non-blank character of the line" })
map("x", "0", "^", { desc = "Go to first non-blank character of the line" })

-- Clear search highlighting
map({ "i", "n", "v" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Saner behavior of n and N
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- }}}

-- Window Management {{{
-- Move to window using the <ctrl> hjkl keys
map({ "n", "v" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map({ "n", "v" }, "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map({ "n", "v" }, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map({ "n", "v" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
-- }}}

-- Buffer Operations {{{
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

map("n", "<leader>l", "<cmd>bnext<cr>", { silent = true, desc = "Go to next buffer" })
map("n", "<leader>h", "<cmd>bprevious<cr>", { silent = true, desc = "Go to previous buffer" })
-- }}}

-- Line Movement {{{
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
-- }}}

-- Quickfix and Location List {{{
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Diagnostic keymaps
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
-- }}}
