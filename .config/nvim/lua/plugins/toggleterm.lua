return {
    'akinsho/toggleterm.nvim',
    config = function()
        require("toggleterm").setup({
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = "<f12>",
            shade_terminals = false,
            autochdir = true,
        })

        function _G.set_terminal_keymaps()
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = "Exit terminal mode", buffer = 0 })
            -- vim.keymap.set('t', 'jj', [[<C-\><C-n>]], { desc = "Exit terminal mode", buffer = 0 })
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Move to left window", buffer = 0 })
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Move to bottom window", buffer = 0 })
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Move to top window", buffer = 0 })
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Move to right window", buffer = 0 })
            vim.keymap.set('t', '<leader>l', [[<nop>]], { desc = "Disable <leader>l in terminal mode", buffer = 0 })
            vim.keymap.set('t', '<leader>h', [[<nop>]], { desc = "Disable <leader>h in terminal mode", buffer = 0 })
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function()
                set_terminal_keymaps()
                vim.cmd([[setlocal nospell]])
                vim.cmd([[set winfixbuf]])
            end,
            desc = "Mappings for navigation with a terminal",
        })
        vim.api.nvim_create_user_command("Exec", function(opts)
            require("toggleterm").exec(opts.args)
        end, { desc = "Run TermExec with the given command", nargs = "*" })

        vim.api.nvim_create_user_command("Tldr", function(opts)
            require("toggleterm").exec("tldr " .. opts.args)
        end, { desc = "Run tldr with the given argument", nargs = 1 })
    end
}
