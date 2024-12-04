return {
	-- {
	-- 	"kylechui/nvim-surround",
	-- 	config = function()
	-- 		require("nvim-surround").setup({})
	-- 	end,
	-- },
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},

	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
		-- ft = { 'tex' }, -- 只在 LaTeX 文件类型加载插件
		config = function()
			require("luasnip-latex-snippets").setup({
				use_treesitter = false, -- whether to use treesitter to determine if cursor is in math mode; if false, vimtex is used
				allow_on_markdown = true, -- whether to add snippets to markdown filetype
			})
		end,
	},
	-- install without yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	config = function()
	-- 		require("nvim-autopairs").setup({})
	-- 	end,
	-- },
}
