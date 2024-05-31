local ok_cmp, cmp = pcall(require, 'cmp')
local ok_lspkind, lspkind = pcall(require, 'lspkind')
local ok_snip, luasnip = pcall(require, 'luasnip')

if not ok_cmp and not ok_snip and not ok_lspkind then return end

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    completion = {
        completeopt = 'menu,menuone,noinsert',
        -- autocomplete = false,
    },
    ---@diagnostic disable-next-line: missing-fields
    formatting = {
        format = lspkind.cmp_format {
            mode = 'symbol',
            with_text = false,
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            menu = {
                buffer = '[BUF]',
                nvim_lsp = '[LSP]',
                nvim_lsp_signature_help = '[LSP]',
                nvim_lsp_document_symbol = '[LSP]',
                nvim_lua = '[API]',
                path = '[PATH]',
                luasnip = '[SNIP]',
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
        { name = 'nvim_lsp' },
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

local cmp_srcs = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
}

local filetypes = {
    'lua',
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
    'php',
    'css',
    'scss',
    'ocaml',
}

for _, filetype in ipairs(filetypes) do
    cmp.setup.filetype(filetype, {
        sources = cmp.config.sources(cmp_srcs),
    })
end

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'nvim_lsp_document_symbol' },
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
