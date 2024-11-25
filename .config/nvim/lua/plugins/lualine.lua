return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			-- set an empty statusline till lualine loads
			vim.o.statusline = " "
		else
			-- hide the statusline on the starter page
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		-- local colors = require("catppuccin.palettes").get_palette("mocha")
		-- PERF: we don't need this lualine require madness 🤷
		local lualine_require = require("lualine_require")
		lualine_require.require = require

		vim.o.laststatus = vim.g.lualine_laststatus

		local opts = {
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
				section_separators = { left = "", right = "" },
				component_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },

				lualine_c = {
					{
						"diagnostics",
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				},
				lualine_x = {
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
					},
					-- {
					-- 	function()
					-- 		return require("noice").api.status.mode.get()
					-- 	end,
					-- 	cond = function()
					-- 		return package.loaded["noice"] and require("noice").api.status.mode.has()
					-- 	end,
					-- },
					{ "copilot" },
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
					},
					{
						"diff",
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = { "neo-tree", "lazy", "toggleterm", "mason", "quickfix" },
		}

		-- do not add trouble symbols if aerial is enabled
		-- And allow it to be overriden for some buffer types (see autocmds)
		return opts
	end,
}
--     {
-- 	"nvim-lualine/lualine.nvim",
-- 	config = function()
-- 		-- Set lualine as statusline
-- 		-- See `:help lualine.txt`
-- 		require("lualine").setup({
-- 			options = {
-- 				icons_enabled = true,
-- 				-- theme = 'edge',
-- 				theme = "catppuccin",
-- 			},
-- 			sections = {
-- 				lualine_a = { "mode" },
-- 				lualine_b = { "branch", "diff", "diagnostics" },
-- 				lualine_c = { "filename", "copilot" },
-- 				lualine_x = { "encoding", "fileformat", "filetype" },
-- 				lualine_y = { "progress" },
-- 				lualine_z = { "location" },
-- 			},
-- 		})
-- 	end,
-- }
