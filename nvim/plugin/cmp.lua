local ok_cmp, cmp = pcall(require, 'cmp')
local ok_lspkind, lspkind = pcall(require, 'lspkind')
local ok_snip, luasnip = pcall(require, 'luasnip')

if not ok_cmp and not ok_snip and not ok_lspkind then return end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

---@param source string|table
local function complete_with_source(source)
    if type(source) == 'string' then
        cmp.complete { config = { sources = { { name = source } } } }
    elseif type(source) == 'table' then
        cmp.complete { config = { sources = { source } } }
    end
end

cmp.setup {
    completion = {
        completeopt = 'menu,menuone,noinsert',
        -- autocomplete = false,
    },
    formatting = {
        format = lspkind.cmp_format {
            mode = 'symbol_text',
            with_text = true,
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            -- symbol_map = {
            --     Copilot = '',
            -- },
            menu = {
                buffer = '[BUF]',
                nvim_lsp = '[LSP]',
                nvim_lsp_signature_help = '[LSP]',
                nvim_lsp_document_symbol = '[LSP]',
                nvim_lua = '[API]',
                path = '[PATH]',
                luasnip = '[SNIP]',
                -- Copilot = '[CPLT]',
            },
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
        ['<C-e>'] = cmp.mapping.abort(), -- close completion window
        ['<CR>'] = cmp.mapping.confirm { select = false },
    },
    sources = cmp.config.sources {
        -- The insertion order influences the priority of the sources
        -- { name = 'copilot' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
    },
    enabled = function() return vim.bo[0].buftype ~= 'prompt' end,
    experimental = {
        native_menu = false,
        ghost_text = true,
    },
}

vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

cmp.setup.filetype('lua', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('typescript', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('javascript', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('typescriptreact', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('javascriptreact', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('php', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('css', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('scss', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

cmp.setup.filetype('ocaml', {
    sources = cmp.config.sources {
        -- { name = 'copilot' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'path' },
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'nvim_lsp_document_symbol', keyword_length = 3 },
        { name = 'buffer' },
    },
    view = {
        entries = { name = 'wildmenu', separator = '|' },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources {
        { name = 'cmdline' },
        { name = 'path' },
    },
})

-- vim.keymap.set({ 'i', 'c', 's' }, '<C-n>', cmp.complete, { noremap = false, desc = '[cmp] complete' })
--
-- vim.keymap.set(
--     { 'i', 'c', 's' },
--     '<C-f>',
--     function() complete_with_source 'path' end,
--     { noremap = false, desc = '[cmp] path' }
-- )
-- vim.keymap.set(
--     { 'i', 'c', 's' },
--     '<C-o>',
--     function() complete_with_source 'nvim_lsp' end,
--     { noremap = false, desc = '[cmp] lsp' }
-- )
-- vim.keymap.set(
--     { 'c' },
--     '<C-c>',
--     function() complete_with_source 'cmdline' end,
--     { noremap = false, desc = '[cmp] cmdline' }
-- )
