local ok_tsc, tsc = pcall(require, 'tsc')

if not ok_tsc then return end

tsc.setup {
    use_trouble_qflist = true,
    run_as_monorepo = true,
}

vim.keymap.set('n', '<leader>Ts', ':TSC<CR>', { silent = true, noremap = true, desc = '[T]SC [s]tart' })
vim.keymap.set('n', '<leader>Tx', ':TSCStop<CR>', { silent = true, noremap = true, desc = 'TSC stop' })
