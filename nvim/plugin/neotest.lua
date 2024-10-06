local ok_neotest, neotest = pcall(require, 'neotest')

if not ok_neotest then return end

local test_icons = require('user.icons').test

---@diagnostic disable-next-line: missing-fields
neotest.setup {
    adapters = {
        require 'neotest-phpunit',
        require 'neotest-vitest' {
            -- -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
            -- filter_dir = function(name, rel_path, root) return name ~= 'node_modules' end,
            -- ---Custom criteria for a file path to determine if it is a vitest test file.
            -- ---@async
            -- ---@param file_path string Path of the potential vitest test file
            -- ---@return boolean
            -- is_test_file = function(file_path)
            --     -- Check if the project is "my-peculiar-project"
            --     if string.match(file_path, 'oneupsales') then
            --         -- Check if the file path includes something else
            --         return string.match(file_path, '.spec.')
            --     end
            --     return false
            -- end,
        },
    },
    icons = {
        failed = test_icons.failed,
        passed = test_icons.passed,
        running = test_icons.running,
        skipped = test_icons.skipped,
    },
}

vim.keymap.set(
    'n',
    '<leader>tr',
    function() neotest.run.run() end,
    { noremap = true, silent = true, desc = '[T]est [r]un nearest' }
)

vim.keymap.set(
    'n',
    '<leader>tR',
    function() neotest.run.run(vim.fn.expand '%') end,
    { noremap = true, silent = true, desc = '[T]est [R]un file' }
)

vim.keymap.set(
    'n',
    '<leader>tc',
    function() neotest.run.stop() end,
    { noremap = true, silent = true, desc = '[T]est [c]ancel nearest' }
)

vim.keymap.set(
    'n',
    '<leader>ta',
    function() neotest.run.attach() end,
    { noremap = true, silent = true, desc = '[T]est [a]ttach to nearest' }
)

vim.keymap.set(
    'n',
    '<leader>to',
    function() neotest.output.open { enter = true, auto_close = true } end,
    { noremap = true, silent = true, desc = '[T]est [o]utput open' }
)

vim.keymap.set(
    'n',
    '<leader>tO',
    function() neotest.output_panel.toggle() end,
    { noremap = true, silent = true, desc = '[T]est [O]utput panel' }
)

vim.keymap.set(
    'n',
    '<leader>ts',
    function() neotest.summary.toggle() end,
    { noremap = true, silent = true, desc = '[T]est [s]ummary' }
)

vim.keymap.set(
    'n',
    '<leader>tw',
    function() neotest.summary.toggle() end,
    { noremap = true, silent = true, desc = '[T]est [w]atch' }
)

vim.keymap.set(
    'n',
    ']t',
    function() neotest.jump.next { status = 'failed' } end,
    { noremap = true, silent = true, desc = 'Jump to next failed [t]est' }
)

vim.keymap.set(
    'n',
    '[t',
    function() neotest.jump.prev { status = 'failed' } end,
    { noremap = true, silent = true, desc = 'Jump to previous failed [t]est' }
)
