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
			lastplace = { enabled = false },
			-- dashboard = {
			-- 	enabled = true,
			-- 	-- example = "startify",
			-- 	-- your dashboard configuration comes here
			-- 	-- or leave it empty to use the default settings
			-- 	-- refer to the configuration section below
			-- 	-- {section = "header", content = "Welcome to Snacks"},
			-- 	sections = {
			-- 		{
			-- 			section = "terminal",
			-- 			cmd = "ascii-image-converter ~/Pictures/avatar/furina.png -C -c",
			-- 			-- random = 10,
			-- 			-- pane = 2,
			-- 			indent = 4,
			-- 			height = 25,
			-- 		},
			-- 		-- { section = "header" },
			-- 		{ section = "keys", gap = 1, padding = 1 },
			-- 		{ section = "startup" },
			-- 	},
			-- },
		})
	end,
}
