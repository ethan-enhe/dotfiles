return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local snacks = require("snacks")
		snacks.setup({
			bigfile = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			bufdelete = { enabled = true },
		})
	end,
}
