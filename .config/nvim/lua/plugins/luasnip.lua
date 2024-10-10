return {
  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config=function ()
        local ls = require("luasnip")
        ls.config.set_config({
                history = true, -- keep around last snippet local to jump back
                enable_autosnippets = true,
                store_selection_keys = "<Tab>",
                updateevents = "TextChanged,TextChangedI",
                })
    -- require("luasnip.loaders.from_vscode").lazy_load()
        -- require("luasnip.loaders.from_snipmate").lazy_load()

        ls.filetype_extend("all", { "_" })

        local snippets_folder = vim.fn.stdpath "config" .. "/lua/snips/"
        require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }
    require("luasnip.loaders.from_vscode").lazy_load()
        vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]
        end
  },
  {
      'iurimateus/luasnip-latex-snippets.nvim',
      dependencies = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
      -- ft = { 'tex' }, -- 只在 LaTeX 文件类型加载插件
          config = function()
          require('luasnip-latex-snippets').setup({
                  use_treesitter = false, -- whether to use treesitter to determine if cursor is in math mode; if false, vimtex is used
                  allow_on_markdown = true, -- whether to add snippets to markdown filetype
                  })
      end,
  },
}
