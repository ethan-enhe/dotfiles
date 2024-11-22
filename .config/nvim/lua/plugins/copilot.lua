local prompts = {
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enable = true,
					auto_trigger = true,
					hide_during_completion = false,
					debounce = 75,
					keymap = {
						accept = "<M-Up>",
						accept_word = "<M-Right>",
						accept_line = "<M-Down>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					markdown = true,
					lua = true,
					help = true,
				},
			})
		end,
	},
	{ "AndreM222/copilot-lualine" },

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		cmd = "CopilotChat",
		opts = function()
			local user = vim.env.USER or "User"
			user = user:sub(1, 1):upper() .. user:sub(2)
			return {
				auto_insert_mode = true,
				auto_follow_cursor = false, -- Don't follow the cursor after getting response
				question_header = "  " .. user .. " ",
				answer_header = "  Copilot ",
				window = {
					width = 0.35,
				},
				mappings = {
					-- Use tab for completion
					complete = {
						detail = "Use @<Tab> or /<Tab> for options.",
						insert = "<Tab>",
					},
					-- Close the chat
					close = {
						normal = "q",
						insert = "<C-c>",
					},
					-- Reset the chat buffer
					reset = {
						normal = "<C-x>",
						insert = "<C-x>",
					},
					-- Submit the prompt to Copilot
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-CR>",
					},
					-- Accept the diff
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
					-- Yank the diff in the response to register
					yank_diff = {
						normal = "gmy",
					},
					-- Show the diff
					show_diff = {
						normal = "gmd",
					},
					-- Show the prompt
					show_system_prompt = {
						normal = "gmp",
					},
					-- Show the user selection
					show_user_selection = {
						normal = "gms",
					},
					-- Show help
					show_help = {
						normal = "gmh",
					},
				},
			}
		end,
		keys = {
			{ "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
			{
				"<leader>av",
				function()
					return require("CopilotChat").toggle()
				end,
				desc = "Toggle (CopilotChat)",
				mode = { "n", "v" },
			},
			{
				"<leader>ax",
				function()
					return require("CopilotChat").reset()
				end,
				desc = "Clear (CopilotChat)",
				mode = { "n", "v" },
			},
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input)
					end
				end,
				desc = "Quick Chat (CopilotChat)",
				mode = { "n", "v" },
			},
			-- Show prompts actions with telescope
			{
				"<leader>ap",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "Prompt Actions (CopilotChat)",
				mode = { "n", "v" },
			},
			{ "<leader>a?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
		},
		config = function(_, opts)
			local chat = require("CopilotChat")

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-chat",
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
				end,
			})

			chat.setup(opts)
		end,
	},
}
