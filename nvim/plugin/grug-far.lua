local ok_grug_far, grug_far = pcall(require, 'grug-far')

if not ok_grug_far then return end

grug_far.setup {
    startCursorRow = 4,
    keymaps = {
        replace = '<C-enter>',
        qflist = '<C-q>',
        gotoLocation = '<enter>',
        close = '<C-x>',
    },
}

vim.keymap.set(
    { 'n', 'v' },
    '<leader>sR',
    function() grug_far.grug_far { prefills = { search = vim.fn.expand '<cword>' } } end,
    { desc = '[S]earch & [R]eplace project', silent = true }
)

vim.keymap.set(
    { 'n', 'v' },
    '<leader>sr',
    function() grug_far.grug_far { prefills = { flags = vim.fn.expand '%', search = vim.fn.expand '<cword>' } } end,
    { desc = '[S]earch & [R]eplace buffer', silent = true }
)
