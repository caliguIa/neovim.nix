local ok_overseer, overseer = pcall(require, 'overseer')

if not ok_overseer then return end

overseer.setup()

vim.keymap.set('n', '<leader>or', function() overseer.run() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ot', function() overseer.toggle() end, { noremap = true, silent = true })
