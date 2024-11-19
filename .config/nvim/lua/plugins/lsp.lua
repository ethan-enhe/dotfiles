-- Compile and run C++ code
vim.keymap.set('n', '<f9>', function()
    local exename = vim.fn.expand("%:p:r") .. ".exe"
    local filename = vim.fn.expand("%:p")
    vim.cmd [[w]]
    vim.cmd("TermExec cmd=\"g++ -std=c++17 -lm -Wall -O2 -fsanitize=address,undefined -D LOCAL " ..
        filename .. " -o " .. exename .. "\"")
end, { silent = true })

vim.keymap.set('n', '<leader><f9>', function()
    local exename = vim.fn.expand("%:p:r") .. ".exe"
    local filename = vim.fn.expand("%:p")
    vim.cmd [[w]]
    vim.cmd("TermExec cmd=\"g++ -std=c++17 -lm -Wall -Ofast -march=native  -fopenmp -lpthread " ..
        filename .. " -o " .. exename .. "\"")
end, { silent = true })

vim.keymap.set('n', '<f8>', function()
    local filename = vim.fn.expand("%:p:r") .. ".exe"
    vim.cmd("TermExec cmd=\"time " .. filename .. "\"")
    -- vim.cmd("wincmd w")
end, { silent = true })
vim.keymap.set('n', '<leader><f8>', function()
    local filename = vim.fn.expand("%:p:r") .. ".exe" .. " < " .. vim.fn.expand("%:p:h") .. "/test.in"
    vim.cmd("TermExec cmd=\"time " .. filename .. "\"")
    -- vim.cmd("wincmd w")
end, { silent = true })



-- Diagnostic keymaps
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>f', '<cmd>Format<cr>', '[F]ormat')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', require('telescope.builtin').lsp_references)
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
local servers = { 'clangd', 'texlab', 'lua_ls' }
return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- nvim-cmp supports additional completion capabilities
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            for _, lsp in ipairs(servers) do
                require('lspconfig')[lsp].setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' }
                            }
                        }
                    }
                }
            end
        end
    }, -- Collection of configurations for built-in LSP client
    {
        'williamboman/mason.nvim',
        config = function()
            -- Setup mason so it can manage external tooling
            require('mason').setup({
            })
        end
    }, -- Manage external editor tooling i.e LSP servers
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            -- Ensure the servers above are installed
            require('mason-lspconfig').setup {
                ensure_installed = servers,
            }
        end
    }, -- Automatically install language servers to stdpath
}
