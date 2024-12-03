return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		spec = {
			{ "<leader>a", group = "[A]i Chat" },
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>y", group = "[Y]ank" },
			{ "<leader>x", group = "Quickfi[x]" },
			{ "<leader>h", group = "Git [H]unk / Previous Buffer", mode = { "n", "v" } },
			{ "<leader>l", group = "Next Buffer", mode = { "n", "v" } },
		},
	},
}
