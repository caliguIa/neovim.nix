local icons = require('user.icons').diagnostics

require('corn').setup {
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
