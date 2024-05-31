local ok_lspconfig, lspconfig = pcall(require, 'lspconfig')
local ok_fzf_lua, fzf_lua = pcall(require, 'fzf-lua')
if not ok_lspconfig then return end

require('neodev').setup {
    override = function(root_dir, library)
        if root_dir:find('/Users/caligula/neovim.nix', 1, true) == 1 then
            library.enabled = true
            library.plugins = true
        end
    end,
    library = {
        plugins = {
            'neotest',
            'nvim-treesitter',
            'plenary.nvim',
        },
        types = true,
    },
}

vim.diagnostic.config { update_in_insert = false }

if vim.fn.executable 'lua-language-server' then
    lspconfig['lua_ls'].setup {
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
                format = {
                    enable = false,
                },
            },
        },
    }
end

-- if vim.fn.executable 'vscode-css-language-server' == 1 then lspconfig['cssls'].setup {} end
-- if vim.fn.executable 'vscode-html-language-server' == 1 then lspconfig['html'].setup {} end
-- if vim.fn.executable 'vscode-json-language-server' == 1 then lspconfig['jsonls'].setup {} end

if vim.fn.executable 'ocamllsp' == 1 then lspconfig['ocamllsp'].setup {} end

if vim.fn.executable 'intelephense' == 1 then
    lspconfig['intelephense'].setup {
        init_options = {
            storagePath = '/tmp/intelephense',
            globalStoragePath = os.getenv 'HOME' .. '/.cache/intelephense',
            licenceKey = os.getenv 'HOME' .. '/.local/auth/intelephense.txt' or '',
        },
        format = { enable = false },
        commands = {
            IntelephenseIndex = {
                function() vim.lsp.buf.execute_command { command = 'intelephense.index.workspace' } end,
            },
        },
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
            if client.server_capabilities.inlayHintProvider then vim.lsp.buf.inlay_hint(bufnr, true) end
        end,
    }
end

if vim.fn.executable 'vscode-eslint-language-server' == 1 then
    lspconfig['eslint'].setup {
        init_options = {
            provideFormatter = true,
        },
        root_dir = lspconfig.util.root_pattern '.eslintrc.json',
        settings = {
            codeAction = {
                disableRuleComment = {
                    enable = true,
                    location = 'separateLine',
                },
                showDocumentation = {
                    enable = true,
                },
            },
            onIgnoredFiles = 'off',
            problems = {
                shortenToSingleLine = false,
            },
            validate = 'on',
            format = true,
            workingDirecotry = {
                mode = 'auto',
            },
        },
        on_new_config = function(config, new_root_dir)
            config.settings.workspaceFolder = {
                uri = new_root_dir,
                name = vim.fs.basename(new_root_dir),
            }
        end,
    }
end

if vim.fn.executable 'nil' == 1 then lspconfig['nil_ls'].setup {} end
if vim.fn.executable 'nixd' == 1 then lspconfig['nixd'].setup {} end

if vim.fn.executable 'gleam' == 1 then lspconfig['gleam'].setup {} end

-- LSP keymappings, triggered when the language server attaches to a buffer.
local function on_attach(event)
    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    vim.diagnostic.enable(true)
    if client == nil then
        vim.notify('No client attached to buffer ' .. bufnr, vim.log.levels.ERROR)
        return
    end

    if not ok_fzf_lua then return end

    local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', function() fzf_lua.lsp_definitions { jump_to_single_result = true } end, '[G]oto [D]efinition')

    map('gr', function() fzf_lua.lsp_references { jump_to_single_result = true } end, '[G]oto [R]eferences')

    map('gt', function() fzf_lua.lsp_typedefs { jump_to_single_result = true } end, 'Type [D]efinition')

    map('<leader>ds', fzf_lua.lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', fzf_lua.lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', fzf_lua.lsp_code_actions, '[C]ode [A]ction')
    -- map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', fzf_lua.lsp_declarations, '[G]oto [D]eclaration')
    map('<leader>e', vim.diagnostic.open_float, 'Show line diagnostics')
    -- map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
    -- map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = on_attach,
})
