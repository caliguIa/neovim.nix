local ok_blame, blame = pcall(require, 'blame-nvim')

if not ok_blame then return end

blame.setup()

vim.keymap.set('n', '<leader>gb', '<CMD>BlameToggle<CR>', { desc = '[G]it [B]lame' })
