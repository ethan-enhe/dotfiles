-- Define the utils module
local utils = require("utils")

-- Return the vimtex plugin configuration
return {
	"lervag/vimtex",
	config = function()
		vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull",
			"Overfull",
			"Package hyperref Warning: Token not allowed in a PDF string",
			"Package typearea Warning: Bad type area settings!",
		}
		vim.opt.conceallevel = 1
		vim.g.tex_conceal = "abdmg"
		vim.g.vimtex_view_method = "zathura"

		-- Compile on initialization, cleanup on quit
		utils.autogroup("vimtex_event_1", {
			{ events = "User", pattern = "VimtexEventQuit", command = "VimtexClean" },
			{ events = "User", pattern = "VimtexEventInitPost", command = "VimtexCompile" },
		})

		-- Close viewers when VimTeX buffers are closed
		function CloseViewers()
			if
				vim.fn.executable("xdotool") == 1
				and vim.b.vimtex.viewer.xwin_id
				and vim.b.vimtex.viewer.xwin_id > 0
			then
				vim.fn.system("xdotool windowclose " .. vim.b.vimtex.viewer.xwin_id)
			end
		end

		utils.autogroup("vimtex_event_2", {
			{ events = "User", pattern = "VimtexEventQuit", command = "lua CloseViewers()" },
		})

		-- Add custom mappings in ToC buffer
		function TocMappings()
			-- vim.api.nvim_buf_set_keymap(0, "n", "q", ":quitall!<CR>", { noremap = true, silent = true, nowait = true })
			utils.buf_map(0, "n", "q", ":quitall!<CR>", { noremap = true, silent = true, nowait = true })
		end

		utils.autogroup("vimtex_event_3", {
			{ events = "User", pattern = "VimtexEventTocCreated", command = "lua TocMappings()" },
		})

		-- Specify window position when opening ToC entries
		utils.autogroup("vimtex_event_4", {
			{ events = "User", pattern = "VimtexEventTocActivated", command = "normal! zt" },
		})

		-- Specify extra behaviour after reverse goto
		utils.autogroup("vimtex_event_5", {
			{ events = "User", pattern = "VimtexEventViewReverse", command = "normal! zMzvzz" },
		})
	end,
}
