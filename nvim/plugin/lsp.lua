local lspconfig = require 'lspconfig'
local fzf_lua = require 'fzf-lua'

vim.diagnostic.config { update_in_insert = false }
vim.diagnostic.enable(true)

local servers = {
    cssls = {},
    html = {},
    jsonls = {
        init_options = {
            provideFormatter = false,
        },
    },
    gleam = {},
    ocamllsp = {},
    nil_ls = {},
    nixd = {},
    rust_analyzer = {
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = 'clippy',
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
                inlayHints = {
                    chainingHints = true,
                    typeHints = true,
                    parameterHints = true,
                    otherHints = true,
                },
            },
        },
    },
    lua_ls = {
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
    },
    intelephense = {
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
    },
    eslint = {
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
    },
}

local function on_attach(event)
    local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', function() fzf_lua.lsp_definitions { jump_to_single_result = true } end, '[G]oto [D]efinition')
    map('gr', function() fzf_lua.lsp_references { jump_to_single_result = true } end, '[G]oto [R]eferences')
    map('gt', function() fzf_lua.lsp_typedefs { jump_to_single_result = true } end, 'Type [D]efinition')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', fzf_lua.lsp_code_actions, '[C]ode [A]ction')
    map('<leader>e', vim.diagnostic.open_float, 'Show line diagnostics')
end

-- Iterate over the servers table to setup each language server
for server, config in pairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        settings = config.settings,
    }
end
