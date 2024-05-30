local ok_corn, corn = pcall(require, 'corn-nvim')

if not ok_corn then return end

local icons = require('user.icons').diagnostics

corn.setup {
    icons = {
        error = icons.ERROR,
        warn = icons.WARN,
        hint = icons.HINT,
        info = icons.INFO,
    },
    item_preprocess_func = function(item) return item end,
}

vim.keymap.set(
    'n',
    '<leader>Et',
    '<cmd>lua require("corn").toggle()<CR>',
    { noremap = true, silent = true, desc = '[E]rrors [t]oggle' }
)

vim.keymap.set(
    'n',
    '<leader>Es',
    '<cmd>lua require("corn").scope_cycle()<CR>',
    { noremap = true, silent = true, desc = '[E]rrors [s]cope' }
)
