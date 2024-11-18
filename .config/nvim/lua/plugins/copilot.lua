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
            require('copilot').setup({
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
    { 'AndreM222/copilot-lualine' },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        cmd = "CopilotChat",
        opts = function()
            local user = vim.env.USER or "User"
            user = user:sub(1, 1):upper() .. user:sub(2)
            return {
                auto_insert_mode = true,
                question_header = "  " .. user .. " ",
                answer_header = "  Copilot ",
                window = {
                    width = 0.4,
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
            { "<leader>a", "",     desc = "+ai",        mode = { "n", "v" } },
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
                mode = { "n", "v" }
            },
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
    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     branch = "canary", -- Use the canary branch if you want to test the latest features but it might be unstable
    --     -- Do not use branch and version together, either use branch or version
    --     dependencies = {
    --         { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
    --         { "nvim-lua/plenary.nvim" },
    --     },
    --     opts = {
    --         auto_insert_mode = true,
    --         question_header = "  " .. "Ethan" .. " ",
    --         answer_header = "  Copilot ",
    --         window = {
    --             width = 0.4,
    --         },
    --         prompts = prompts,
    --         auto_follow_cursor = false, -- Don't follow the cursor after getting response
    --         -- show_help = true, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
    --         mappings = {
    --             -- Use tab for completion
    --             complete = {
    --                 detail = "Use @<Tab> or /<Tab> for options.",
    --                 insert = "<Tab>",
    --             },
    --             -- Close the chat
    --             close = {
    --                 normal = "q",
    --                 insert = "<C-c>",
    --             },
    --             -- Reset the chat buffer
    --             reset = {
    --                 normal = "<C-x>",
    --                 insert = "<C-x>",
    --             },
    --             -- Submit the prompt to Copilot
    --             submit_prompt = {
    --                 normal = "<CR>",
    --                 insert = "<C-CR>",
    --             },
    --             -- Accept the diff
    --             accept_diff = {
    --                 normal = "<C-y>",
    --                 insert = "<C-y>",
    --             },
    --             -- Yank the diff in the response to register
    --             yank_diff = {
    --                 normal = "gmy",
    --             },
    --             -- Show the diff
    --             show_diff = {
    --                 normal = "gmd",
    --             },
    --             -- Show the prompt
    --             show_system_prompt = {
    --                 normal = "gmp",
    --             },
    --             -- Show the user selection
    --             show_user_selection = {
    --                 normal = "gms",
    --             },
    --             -- Show help
    --             show_help = {
    --                 normal = "gmh",
    --             },
    --         },
    --     },
    --     config = function(_, opts)
    --         local chat = require("CopilotChat")
    --         local select = require("CopilotChat.select")
    --         -- Use unnamed register for the selection
    --         opts.selection = select.unnamedplus
    --
    --         -- Override the git prompts message
    --         opts.prompts.Commit = {
    --             prompt = "Write commit message for the change with commitizen convention",
    --             selection = select.gitdiff,
    --         }
    --         opts.prompts.CommitStaged = {
    --             prompt = "Write commit message for the change with commitizen convention",
    --             selection = function(source)
    --                 return select.gitdiff(source, true)
    --             end,
    --         }
    --
    --         chat.setup(opts)
    --
    --         vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
    --             chat.ask(args.args, { selection = select.visual })
    --         end, { nargs = "*", range = true })
    --
    --
    --         vim.api.nvim_create_autocmd("BufEnter", {
    --             pattern = "copilot-chat",
    --             callback = function()
    --                 vim.opt_local.relativenumber = false
    --                 vim.opt_local.number = false
    --             end,
    --         })
    --         -- Inline chat with Copilot
    --         vim.api.nvim_create_user_command("CopilotChatInline", function(args)
    --             chat.ask(args.args, {
    --                 selection = select.visual,
    --                 window = {
    --                     layout = "float",
    --                     relative = "cursor",
    --                     width = 1,
    --                     height = 0.4,
    --                     row = 1,
    --                 },
    --             })
    --         end, { nargs = "*", range = true })
    --
    --         -- Restore CopilotChatBuffer
    --         vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
    --             chat.ask(args.args, { selection = select.buffer })
    --         end, { nargs = "*", range = true })
    --     end,
    --     event = "VeryLazy",
    --     keys = {
    --         -- Show help actions with telescope
    --         {
    --             "<leader>ah",
    --             function()
    --                 local actions = require("CopilotChat.actions")
    --                 require("CopilotChat.integrations.telescope").pick(actions.help_actions())
    --             end,
    --             desc = "CopilotChat - Help actions",
    --         },
    --         -- Show prompts actions with telescope
    --         {
    --             "<leader>ap",
    --             function()
    --                 local actions = require("CopilotChat.actions")
    --                 require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    --             end,
    --             desc = "CopilotChat - Prompt actions",
    --         },
    --         {
    --             "<leader>ap",
    --             ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
    --             mode = "x",
    --             desc = "CopilotChat - Prompt actions",
    --         },
    --         -- Code related commands
    --         { "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "CopilotChat - Explain code" },
    --         { "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "CopilotChat - Generate tests" },
    --         { "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "CopilotChat - Review code" },
    --         { "<leader>aR", "<cmd>CopilotChatRefactor<cr>",      desc = "CopilotChat - Refactor code" },
    --         { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
    --         -- Chat with Copilot in visual mode
    --         {
    --             "<leader>av",
    --             ":CopilotChatVisual<cr>",
    --             mode = "x",
    --             desc = "CopilotChat - Open in vertical split",
    --         },
    --         {
    --             "<leader>ax",
    --             ":CopilotChatInline<cr>",
    --             mode = "x",
    --             desc = "CopilotChat - Inline chat",
    --         },
    --         -- Custom input for CopilotChat
    --         {
    --             "<leader>ai",
    --             function()
    --                 local input = vim.fn.input("Ask Copilot: ")
    --                 if input ~= "" then
    --                     vim.cmd("CopilotChat " .. input)
    --                 end
    --             end,
    --             desc = "CopilotChat - Ask input",
    --         },
    --         -- Generate commit message based on the git diff
    --         {
    --             "<leader>am",
    --             "<cmd>CopilotChatCommit<cr>",
    --             desc = "CopilotChat - Generate commit message for all changes",
    --         },
    --         {
    --             "<leader>aM",
    --             "<cmd>CopilotChatCommitStaged<cr>",
    --             desc = "CopilotChat - Generate commit message for staged changes",
    --         },
    --         -- Quick chat with Copilot
    --         {
    --             "<leader>aq",
    --             function()
    --                 local input = vim.fn.input("Quick Chat: ")
    --                 if input ~= "" then
    --                     vim.cmd("CopilotChatBuffer " .. input)
    --                 end
    --             end,
    --             desc = "CopilotChat - Quick chat",
    --         },
    --         -- Debug
    --         { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>",     desc = "CopilotChat - Debug Info" },
    --         -- Fix the issue with diagnostic
    --         { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
    --         -- Clear buffer and chat history
    --         { "<leader>al", "<cmd>CopilotChatReset<cr>",         desc = "CopilotChat - Clear buffer and chat history" },
    --         -- Toggle Copilot Chat Vsplit
    --         { "<leader>av", "<cmd>CopilotChatToggle<cr>",        desc = "CopilotChat - Toggle" },
    --         -- Copilot Chat Models
    --         { "<leader>a?", "<cmd>CopilotChatModels<cr>",        desc = "CopilotChat - Select Models" },
    --     },
    -- },
}
