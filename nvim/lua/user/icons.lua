local M = {}

--- Diagnostic severities.
M.diagnostics = {
    ERROR = ' ',
    WARN = ' ',
    HINT = ' ',
    INFO = ' ',
}

--- For folding.
M.arrows = {
    right = ' ',
    left = ' ',
    up = ' ',
    down = ' ',
}

--- LSP symbol kinds.
M.symbol_kinds = {
    Array = '󰅪 ',
    Class = ' ',
    Color = '󰏘 ',
    Constant = '󰏿 ',
    Constructor = ' ',
    Enum = ' ',
    EnumMember = ' ',
    Event = '',
    Field = '󰜢 ',
    File = ' ',
    Folder = ' ',
    Function = '󰆧 ',
    Interface = ' ',
    Keyword = '󰌋 ',
    Method = '󰆧 ',
    Module = ' ',
    Operator = '󰆕 ',
    Property = '󰜢 ',
    Reference = '󰈇 ',
    Snippet = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = ' ',
    Value = ' ',
    Variable = '󰀫',
}

--- Shared icons that don't really fit into a category.
M.misc = {
    bug = ' ',
    ellipsis = '…',
    git = ' ',
    search = ' ',
    search_files = '󰱼 ',
    vertical_bar = '│',
    circle = '●',
    lazy = '󰒲 ',
    restore = ' ',
    text = ' ',
    quit = ' ',
    bolt = '⚡',
}

M.test = {
    failed = '✖',
    passed = '✔',
    running = ' ',
    skipped = 'ﰸ ',
}

M.git = {
    LineAdded = '',
    LineModified = '',
    LineRemoved = '',
    LineLeft = '▎',
    LineMiddle = '│',
}

return M