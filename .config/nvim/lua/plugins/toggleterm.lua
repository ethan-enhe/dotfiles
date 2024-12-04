local map = require("utils").map
return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.3
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = "<f12>",
			shade_terminals = false,
			autochdir = true,
		})

		function _G.set_terminal_keymaps()
			map("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode", buffer = 0 })
			map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move to left window", buffer = 0 })
			map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move to bottom window", buffer = 0 })
			map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move to top window", buffer = 0 })
			map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move to right window", buffer = 0 })
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			callback = function()
				set_terminal_keymaps()
				vim.cmd([[setlocal nospell]])
				-- vim.cmd([[set winfixbuf]])
			end,
			desc = "Mappings for navigation with a terminal",
		})
		vim.api.nvim_create_user_command("Exec", function(opts)
			require("toggleterm").exec(opts.args)
		end, { desc = "Run TermExec with the given command", nargs = "*" })

		vim.api.nvim_create_user_command("Tldr", function(opts)
			require("toggleterm").exec("tldr " .. opts.args)
		end, { desc = "Run tldr with the given argument", nargs = 1 })

		-- Compile and run C++ code
		-- Map <f9> to compile the current C++ file with debugging flags and AddressSanitizer enabled
		map("n", "<f9>", function()
			local exename = vim.fn.expand("%:p:r") .. ".exe"
			local filename = vim.fn.expand("%:p")
			vim.cmd([[w]])
			vim.cmd(
				'TermExec cmd="g++ -std=c++17 -lm -Wall -O2 -fsanitize=address,undefined -D LOCAL '
					.. filename
					.. " -o "
					.. exename
					.. '"'
			)
		end, { desc = "Compile with debugging flags" })

		map("n", "<leader><f9>", function()
			local exename = vim.fn.expand("%:p:r") .. ".exe"
			local filename = vim.fn.expand("%:p")
			vim.cmd([[w]])
			vim.cmd(
				'TermExec cmd="g++ -std=c++17 -lm -Wall -Ofast -march=native  -fopenmp -lpthread '
					.. filename
					.. " -o "
					.. exename
					.. '"'
			)
		end, { desc = "Compile with optimization flags" })

		map("n", "<f8>", function()
			local filename = vim.fn.expand("%:p:r") .. ".exe"
			vim.cmd('TermExec cmd="time ' .. filename .. '"')
		end, { desc = "Run and measure time" })

		map("n", "<leader><f8>", function()
			local filename = vim.fn.expand("%:p:r") .. ".exe" .. " < " .. vim.fn.expand("%:p:h") .. "/test.in"
			vim.cmd('TermExec cmd="time ' .. filename .. '"')
		end, { desc = "Run with input and measure time" })
	end,
}
