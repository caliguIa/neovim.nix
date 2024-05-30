local ok_neogit, neogit = pcall(require, 'neogit')

if not ok_neogit then return end

neogit.setup {
    disable_builtin_notifications = true,
    disable_insert_on_commit = 'auto',
    integrations = {
        diffview = true,
        telescope = false,
        fzf_lua = true,
    },
    sections = {
        ---@diagnostic disable-next-line: missing-fields
        recent = {
            folded = false,
        },
    },
}

vim.keymap.set('n', '<leader>gg', neogit.open, { noremap = true, silent = true, desc = 'neo[g]it open' })

vim.keymap.set(
    'n',
    '<leader>gc',
    function() neogit.open { 'commit' } end,
    { noremap = true, silent = true, desc = 'neo[g]it [c]ommit' }
)
