local ok_undotree, undotree = pcall(require, 'undotree')
if not ok_undotree then return end

undotree.setup()

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { noremap = true, silent = true, desc = '[U]ndo tree' })
