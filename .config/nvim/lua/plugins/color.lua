return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					mason = true,
					nvim_surround = true,
					which_key = true,
				},
				transparent_background = true,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
		integrations = {
			notify = true,
			nvim_surround = true,
			fidget = true,
			mason = true,
			noice = true,
			which_key = true,
			snacks = true,
		},
	},
	-- {
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("cyberdream").setup({
	-- 			-- Enable transparent background
	-- 			transparent = true,
	--
	-- 			-- Enable italics comments
	-- 			italic_comments = false,
	--
	-- 			-- Replace all fillchars with ' ' for the ultimate clean look
	-- 			hide_fillchars = false,
	--
	-- 			-- Modern borderless telescope theme - also applies to fzf-lua
	-- 			borderless_telescope = true,
	--
	-- 			-- Set terminal colors used in `:terminal`
	-- 			terminal_colors = true,
	--
	-- 			-- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
	-- 			cache = false,
	-- 		})
	-- 		vim.cmd("colorscheme cyberdream")
	-- 	end,
	-- },
	-- {
	-- 	"mjlbach/onedark.nvim", -- Theme inspired by Atom
	-- },
	-- {
	-- 	"sainnhe/edge",
	-- },
}
