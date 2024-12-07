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
		},
	},
	{
		"mjlbach/onedark.nvim", -- Theme inspired by Atom
	},
	{
		"sainnhe/edge",
	},
}
