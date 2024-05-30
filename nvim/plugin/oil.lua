local ok_oil, oil = pcall(require, 'oil')

if not ok_oil then return end

oil.setup {
    default_file_explorer = true,
    columns = { 'icon' },
    win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
    },
    view_options = {
        show_hidden = true,
    },
}

vim.keymap.set('n', '<leader>fe', '<CMD>Oil<CR>', { desc = '[F]ile [E]xplorer' })
