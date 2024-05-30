local ok_diffview, diffview = pcall(require, 'diffview')

if not ok_diffview then return end

vim.keymap.set(
    'n',
    '<leader>gfb',
    function() vim.cmd.DiffviewFileHistory(vim.api.nvim_buf_get_name(0)) end,
    { desc = 'current buffer history' }
)
vim.keymap.set('n', '<leader>gh', vim.cmd.DiffviewFileHistory, { desc = 'File history' })
vim.keymap.set('n', '<leader>gd', vim.cmd.DiffviewOpen, { desc = '[g]it [d]iffview' })
