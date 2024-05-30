local ok_tst, tst = pcall(require, 'typescript-tools')

if not ok_tst then return end

tst.setup {
    on_attach = function(client, bufnr) require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr) end,
    expose_as_code_action = 'all',
    jsx_close_tag = {
        enable = true,
        filetypes = { 'javascriptreact', 'typescriptreact' },
    },
    settings = {
        tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayVariableTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
        },
        typescript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
            },
        },
    },
}
