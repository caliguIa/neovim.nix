local ok_overseer, overseer = pcall(require, 'overseer')

if not ok_overseer then return end

overseer.setup {}

vim.keymap.set('n', '<leader>or', '<CMD>OverseerRun<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ot', '<CMD>OverseerToggle<CR>', { noremap = true, silent = true })
