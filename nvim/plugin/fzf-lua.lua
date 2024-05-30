local ok_fzf, fzf = pcall(require, 'fzf-lua')
local ok_fzf_actions, actions = pcall(require, 'fzf-lua.actions')

if not ok_fzf and not ok_fzf_actions then return end

local icons = require 'user.icons'

fzf.setup {
    fzf_colors = {
        ['bg'] = { 'bg', 'Normal' },
        ['gutter'] = '-1',
        ['bg+'] = { 'bg', 'Normal' },
        ['info'] = { 'fg', 'Conditional' },
        ['scrollbar'] = { 'bg', 'Normal' },
        ['separator'] = { 'fg', 'Comment' },
    },
    fzf_opts = {
        ['--layout'] = 'reverse-list',
        ['--keep-right'] = '',
    },
    keymap = {
        builtin = {
            ['<C-/>'] = 'toggle-help',
            ['<C-a>'] = 'toggle-fullscreen',
            ['<C-i>'] = 'toggle-preview',
            ['<C-f>'] = 'preview-page-down',
            ['<C-b>'] = 'preview-page-up',
        },
    },
    winopts = {
        height = 0.8,
        width = 0.7,
        preview = {
            default = 'bat',
            scrollbar = false,
            layout = 'vertical',
            vertical = 'up:40%',
        },
    },
    global_git_icons = false,
    -- Configuration for specific commands.
    files = {
        winopts = {
            preview = { hidden = 'hidden' },
        },
    },
    grep = {
        header_prefix = icons.misc.search .. ' ',
    },
    helptags = {
        actions = {
            -- Open help pages in a vertical split.
            ['default'] = actions.help_vert,
        },
    },
    lsp = {
        symbols = {
            symbol_icons = icons.symbol_kinds,
        },
    },
    previewers = {
        builtin = {
            syntax_limit_l = 5000,
            syntax_limit_b = 250 * 1024, -- 250 KB
            limit = 1024 * 1024, -- 1 MB
        },
    },
}

vim.keymap.set('n', '<leader>s.', function() fzf.resume() end, { noremap = true, silent = true, desc = 'fzf resume' })

vim.keymap.set(
    'n',
    '<leader>s/',
    function() fzf.lgrep_curbuf() end,
    { noremap = true, silent = true, desc = 'function() fzf.grep current buffer' }
)

vim.keymap.set(
    'n',
    '<leader>sc',
    function() fzf.highlights() end,
    { noremap = true, silent = true, desc = 'fzf highlights' }
)

vim.keymap.set(
    'n',
    '<leader>sd',
    function() fzf.lsp_document_diagnostics() end,
    { noremap = true, silent = true, desc = 'function() fzf.document diagnostics' }
)

vim.keymap.set(
    'n',
    '<leader>sD',
    function() fzf.lsp_workspace_diagnostics() end,
    { noremap = true, silent = true, desc = 'function() fzf.workspace diagnostics' }
)

vim.keymap.set('n', '<leader>sf', function() fzf.files() end, { noremap = true, silent = true, desc = 'fzf files' })

vim.keymap.set(
    'n',
    '<leader>sg',
    function() fzf.live_grep_glob() end,
    { noremap = true, silent = true, desc = 'fzf live grep' }
)

vim.keymap.set(
    'x',
    '<leader>sv',
    function() fzf.grep_visual() end,
    { noremap = true, silent = true, desc = 'fzf visual grep' }
)

vim.keymap.set('n', '<leader>sh', function() fzf.help_tags() end, { noremap = true, silent = true, desc = 'fzf help' })

vim.keymap.set('n', '<leader>sb', function() fzf.buffers() end, { noremap = true, silent = true, desc = 'fzf buffers' })
