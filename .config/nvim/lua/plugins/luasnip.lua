return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- Follow latest release
		build = "make install_jsregexp", -- Install jsregexp (optional)
		dependencies = {
			"rafamadriz/friendly-snippets",
			"iurimateus/luasnip-latex-snippets.nvim",
		},
		config = function()
			local ok, ls = pcall(require, "luasnip")
			if not ok then
				print("Error loading LuaSnip: " .. ls)
				return
			end

			ls.config.set_config({
				history = true, -- Keep around last snippet local to jump back
				enable_autosnippets = true,
				store_selection_keys = "<Tab>",
				updateevents = "TextChanged,TextChangedI",
			})

			ls.filetype_extend("all", { "_" })

			local snippets_folder = vim.fn.stdpath("config") .. "/lua/snips/"
			require("luasnip.loaders.from_lua").lazy_load({ paths = { snippets_folder } })
			require("luasnip.loaders.from_vscode").lazy_load()

			vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		config = function()
			require("luasnip-latex-snippets").setup({
				use_treesitter = false, -- Use vimtex if false
				allow_on_markdown = true, -- Add snippets to markdown filetype
			})
		end,
	},
}
