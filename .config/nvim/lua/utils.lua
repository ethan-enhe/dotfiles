local M = {}

function M.augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Define the autogroup function in utils
function M.autogroup(name, cmds)
	local group = M.augroup(name)
	for _, cmd in ipairs(cmds) do
		vim.api.nvim_create_autocmd(cmd.events, {
			group = group,
			pattern = cmd.pattern,
			command = cmd.command,
		})
	end
end

-- Function to map keys
function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Function to create a buffer-local keymap
function M.buf_map(bufnr, mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true, buffer = bufnr }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Function to set options
function M.set_option(scope, key, value)
	if scope == "o" then
		vim.o[key] = value
	elseif scope == "b" then
		vim.bo[key] = value
	elseif scope == "w" then
		vim.wo[key] = value
	end
end

-- Function to create a command
function M.command(name, fn)
	vim.api.nvim_create_user_command(name, fn, {})
end

-- Function to create a buffer-local autocommand
function M.buf_autocmd(bufnr, event, cmd)
	vim.api.nvim_buf_create_autocmd(bufnr, {
		event = event,
		command = cmd,
	})
end

-- Function to reload a module
function M.reload_module(name)
	package.loaded[name] = nil
	return require(name)
end

return M
