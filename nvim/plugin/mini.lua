local ok_mini_pairs, mini_pairs = pcall(require, 'mini.pairs')

if not ok_mini_pairs then return end

mini_pairs.setup {
    mappings = {
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\`].', register = { cr = false } },
    },
}

local ok_mini_surround, mini_surround = pcall(require, 'mini.surround')

if not ok_mini_surround then return end

mini_surround.setup {
    mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
    },
}

local ok_mini_cursorword, mini_cursorword = pcall(require, 'mini.cursorword')

if not ok_mini_cursorword then return end

mini_cursorword.setup()

local ok_mini_basics, mini_basics = pcall(require, 'mini.basics')

if not ok_mini_basics then return end

mini_basics.setup()
