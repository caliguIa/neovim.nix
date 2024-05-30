if vim.g.did_load_autocommands_plugin then return end
vim.g.did_load_autocommands_plugin = true

local api = vim.api

local tempdirgroup = api.nvim_create_augroup('tempdir', { clear = true })
-- Do not set undofile for files in /tmp
api.nvim_create_autocmd('BufWritePre', {
    pattern = '/tmp/*',
    group = tempdirgroup,
    callback = function() vim.cmd.setlocal 'noundofile' end,
})

-- Disable spell checking in terminal buffers
local nospell_group = api.nvim_create_augroup('nospell', { clear = true })
api.nvim_create_autocmd('TermOpen', {
    group = nospell_group,
    callback = function() vim.wo[0].spell = false end,
})

--- Don't create a comment string when hitting <Enter> on a comment line
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('DisableNewLineAutoCommentString', {}),
    callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' } end,
})

-- highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*',
})
