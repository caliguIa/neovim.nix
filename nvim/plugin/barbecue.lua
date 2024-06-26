local ok_barbecue, barbecue = pcall(require, 'barbecue')

if not ok_barbecue then return end

barbecue.setup {
    create_autocmd = false, -- prevent barbecue from updating itself automatically
    theme = 'melange',
    show_modified = true,
}

vim.api.nvim_create_autocmd({
    'WinScrolled',
    'BufWinEnter',
    'CursorHold',
    'InsertLeave',
    'BufModifiedSet',
}, {
    group = vim.api.nvim_create_augroup('barbecue.updater', {}),
    callback = function() require('barbecue.ui').update() end,
})
