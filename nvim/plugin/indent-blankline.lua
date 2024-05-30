local ok_ibl, ibl = pcall(require, 'ibl')

if not ok_ibl then return end

ibl.setup {
    indent = {
        char = '│',
        tab_char = '│',
    },
    scope = { enabled = false },
    exclude = {
        filetypes = {
            'help',
            'alpha',
            'Trouble',
            'trouble',
            'lazy',
            'mason',
            'oil',
            'Oil',
            'DashboardLoaded',
            'dashboard',
        },
    },
}
