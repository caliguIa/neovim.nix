local ok_grug_far, grug_far = pcall(require, 'grug-far')

if not ok_grug_far then return end

grug_far.setup()

vim.keymap.set(
    { 'n', 'v' },
    '<leader>sR',
    '<CMD>lua require("grug-far").grug_far({ prefills = { search = vim.fn.expand("<cword>") } })<CR>',
    { desc = '[S]earch & [R]eplace project', silent = true }
)

vim.keymap.set(
    { 'n', 'v' },
    '<leader>sr',
    '<CMD>lua require("grug-far").grug_far({ prefills = { flags = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })<CR>',
    { desc = '[S]earch & [R]eplace buffer', silent = true }
)
