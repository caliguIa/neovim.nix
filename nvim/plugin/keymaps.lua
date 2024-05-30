if vim.g.did_load_keymaps_plugin then return end
vim.g.did_load_keymaps_plugin = true

local api = vim.api
local fn = vim.fn
local keymap = vim.keymap
local diagnostic = vim.diagnostic

-- Yank from current position till end of current line
keymap.set('n', 'Y', 'y$', { silent = true, desc = '[Y]ank to end of line' })

-- Buffer list navigation
keymap.set('n', '[b', vim.cmd.bprevious, { silent = true, desc = 'previous [b]uffer' })
keymap.set('n', ']b', vim.cmd.bnext, { silent = true, desc = 'next [b]uffer' })

keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>wh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>we', '<C-w>=', { desc = 'Make splits equal size' })
keymap.set('n', '<leader>wx', '<cmd>close<CR>', { desc = 'Close current split' })

keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Toggle the quickfix list (only opens if it is populated)
local function toggle_qf_list()
    local qf_exists = false
    for _, win in pairs(fn.getwininfo() or {}) do
        if win['quickfix'] == 1 then qf_exists = true end
    end
    if qf_exists == true then
        vim.cmd.cclose()
        return
    end
    if not vim.tbl_isempty(vim.fn.getqflist()) then vim.cmd.copen() end
end

keymap.set('n', '<C-c>', toggle_qf_list, { desc = 'toggle quickfix list' })

local function try_fallback_notify(opts)
    local success, _ = pcall(opts.try)
    if success then return end
    success, _ = pcall(opts.fallback)
    if success then return end
    vim.notify(opts.notify, vim.log.levels.INFO)
end

-- Cycle the quickfix and location lists
local function cleft()
    try_fallback_notify {
        try = vim.cmd.cprev,
        fallback = vim.cmd.clast,
        notify = 'Quickfix list is empty!',
    }
end

local function cright()
    try_fallback_notify {
        try = vim.cmd.cnext,
        fallback = vim.cmd.cfirst,
        notify = 'Quickfix list is empty!',
    }
end

keymap.set('n', '[c', cleft, { silent = true, desc = '[c]ycle quickfix left' })
keymap.set('n', ']c', cright, { silent = true, desc = '[c]ycle quickfix right' })
keymap.set('n', '[C', vim.cmd.cfirst, { silent = true, desc = 'first quickfix entry' })
keymap.set('n', ']C', vim.cmd.clast, { silent = true, desc = 'last quickfix entry' })

-- Resize vertical splits
local toIntegral = math.ceil
keymap.set('n', '<leader>w+', function()
    local curWinWidth = api.nvim_win_get_width(0)
    api.nvim_win_set_width(0, toIntegral(curWinWidth * 3 / 2))
end, { silent = true, desc = 'inc window [w]idth' })

keymap.set('n', '<leader>w-', function()
    local curWinWidth = api.nvim_win_get_width(0)
    api.nvim_win_set_width(0, toIntegral(curWinWidth * 2 / 3))
end, { silent = true, desc = 'dec window [w]idth' })

keymap.set('n', '<leader>h+', function()
    local curWinHeight = api.nvim_win_get_height(0)
    api.nvim_win_set_height(0, toIntegral(curWinHeight * 3 / 2))
end, { silent = true, desc = 'inc window [h]eight' })

keymap.set('n', '<leader>h-', function()
    local curWinHeight = api.nvim_win_get_height(0)
    api.nvim_win_set_height(0, toIntegral(curWinHeight * 2 / 3))
end, { silent = true, desc = 'dec window [h]eight' })

-- Close floating windows [Neovim 0.10 and above]
keymap.set(
    'n',
    '<leader>fq',
    function() vim.cmd 'fclose!' end,
    { silent = true, desc = '[f]loating windows: [q]uit/close all' }
)

keymap.set('n', '<space>tn', vim.cmd.tabnew, { desc = '[t]ab: [n]ew' })
keymap.set('n', '<space>tq', vim.cmd.tabclose, { desc = '[t]ab: [q]uit/close' })

keymap.set('n', '<leader>e', function()
    local _, winid = diagnostic.open_float(nil, { scope = 'line' })
    if not winid then
        vim.notify('no diagnostics found', vim.log.levels.INFO)
        return
    end
    vim.api.nvim_win_set_config(winid or 0, { focusable = true })
end, { noremap = true, silent = true, desc = 'diagnostics floating window' })
keymap.set('n', '[d', diagnostic.goto_prev, { noremap = true, silent = true, desc = 'previous [d]iagnostic' })
keymap.set('n', ']d', diagnostic.goto_next, { noremap = true, silent = true, desc = 'next [d]iagnostic' })

local function toggle_spell_check()
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.opt.spell = not (vim.opt.spell:get())
end

keymap.set('n', '<leader>S', toggle_spell_check, { noremap = true, silent = true, desc = 'toggle [S]pell' })

keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'move [d]own half-page and center' })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'move [u]p half-page and center' })
keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'move DOWN [f]ull-page and center' })
keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'move UP full-page and center' })
