if vim.g.did_load_dashboard_plugin then return end
vim.g.did_load_dashboard_plugin = true

local icons = require 'user.icons'

local logo = [[ neobim ]]

require('dashboard').setup {
    theme = 'doom',
    hide = {
        statusline = false,
    },
    config = {
        header = vim.split(string.rep('\n', 8) .. logo .. '\n\n', '\n'),
        center = {
            {
                action = 'ene | startinsert',
                desc = ' New File' .. string.rep(' ', 44 - #' New File'),
                icon = icons.symbol_kinds.File,
                key = 'n',
            },
            {
                action = 'Oil',
                desc = ' File explorer' .. string.rep(' ', 44 - #' File explorer'),
                icon = icons.symbol_kinds.Folder,
                key = 'e',
            },
            {
                action = 'FzfLua files',
                desc = ' Find File' .. string.rep(' ', 44 - #' Find File'),
                icon = icons.misc.search,
                key = 'f',
            },
            {
                action = 'FzfLua live_grep_glob',
                desc = ' Find Text' .. string.rep(' ', 44 - #' Find Text'),
                icon = icons.misc.text,
                key = 'g',
            },
            {
                action = 'lua require("persistence").load()',
                desc = ' Restore Session' .. string.rep(' ', 44 - #' Restore Session'),
                icon = icons.misc.restore,
                key = 'r',
            },
            {
                action = 'qa',
                desc = ' Quit' .. string.rep(' ', 44 - #' Quit'),
                icon = icons.misc.quit,
                key = 'q',
            },
        },
    },
}
