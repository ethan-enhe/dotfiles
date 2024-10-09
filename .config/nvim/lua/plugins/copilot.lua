return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config=function()
      require('copilot').setup({
        suggestion = {
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
        },
      })
    end,
  },
  { 'AndreM222/copilot-lualine' },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    config = function()
      require("CopilotChat").setup({
        debug = true, -- Enable debugging
        -- See Configuration section for rest
        question_header = "## User ",
        answer_header = "## Copilot ",
        error_header = "## Error ",
        auto_follow_cursor = false, -- Don't follow the cursor after getting response
        show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
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
      })
      local keymap = vim.api.nvim_set_keymap
      local opts = { silent = true, noremap = true }

      keymap('x', '<leader>ae', '<cmd>CopilotChatExplain<cr>', opts)
      keymap('x', '<leader>at', '<cmd>CopilotChatTests<cr>', opts)
      keymap('x', '<leader>ar', '<cmd>CopilotChatReview<cr>', opts)
      keymap('x', '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', opts)

      -- Custom input for CopilotChat
      keymap('x', '<leader>ai', ':lua AskCopilot()<cr>', opts)
      function AskCopilot()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          vim.cmd("CopilotChat " .. input)
        end
      end

      -- Generate commit message based on the git diff
      keymap('n', '<leader>am', '<cmd>CopilotChatCommit<cr>', opts)
      keymap('n', '<leader>aM', '<cmd>CopilotChatCommitStaged<cr>', opts)


      -- Debug
      keymap('n', '<leader>ad', '<cmd>CopilotChatDebugInfo<cr>', opts)

      -- Fix the issue with diagnostic
      keymap('n', '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', opts)

      -- Clear buffer and chat history
      keymap('n', '<leader>al', '<cmd>CopilotChatReset<cr>', opts)

      -- Toggle Copilot Chat Vsplit
      keymap('n', '<leader>av', '<cmd>CopilotChatToggle<cr>', opts)

      -- Copilot Chat Models
      keymap('n', '<leader>a?', '<cmd>CopilotChatModels<cr>', opts)
    end,
  },
}
