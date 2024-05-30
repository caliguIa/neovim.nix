local ok_trouble, trouble = pcall(require, 'trouble')
if not ok_trouble then return end

trouble.setup {
    use_diagnostic_signs = true,
}

vim.keymap.set('n', '<leader>xx', function() trouble.toggle() end)
vim.keymap.set('n', '<leader>xw', function() trouble.toggle 'workspace_diagnostics' end)
vim.keymap.set('n', '<leader>xd', function() trouble.toggle 'document_diagnostics' end)
vim.keymap.set('n', '<leader>xq', function() trouble.toggle 'quickfix' end)
vim.keymap.set('n', '<leader>xl', function() trouble.toggle 'loclist' end)
