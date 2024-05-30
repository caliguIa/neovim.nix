local ok_harpoon, harpoon = pcall(require, 'harpoon')

if not ok_harpoon then return end

harpoon:setup()

vim.keymap.set(
    'n',
    '<leader>h',
    function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { noremap = true, silent = true, desc = '[H]arpoon menu' }
)

vim.keymap.set('n', 'ma', function() harpoon:list():add() end, { noremap = true, silent = true, desc = '[M]ark [A]dd' })

vim.keymap.set(
    'n',
    'mj',
    function() harpoon:list():select(1) end,
    { noremap = true, silent = true, desc = 'Jump to [M]ark [1]' }
)

vim.keymap.set(
    'n',
    'mk',
    function() harpoon:list():select(2) end,
    { noremap = true, silent = true, desc = 'Jump to [M]ark [2]' }
)

vim.keymap.set(
    'n',
    'ml',
    function() harpoon:list():select(3) end,
    { noremap = true, silent = true, desc = 'Jump to [M]ark [3]' }
)

vim.keymap.set(
    'n',
    'm;',
    function() harpoon:list():select(4) end,
    { noremap = true, silent = true, desc = 'Jump to [M]ark [4]' }
)
