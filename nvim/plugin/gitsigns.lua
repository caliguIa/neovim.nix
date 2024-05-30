local ok_gitsigns, gitsigns = pcall(require, 'gitsigns')

if not ok_gitsigns then return end

vim.schedule(function()
    gitsigns.setup {
        current_line_blame = false,
        current_line_blame_opts = {
            ignore_whitespace = true,
        },
        signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        numhl = true, -- Toggle with `:Gitsigns toggle_nunhl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        sign_priority = 9,
        watch_gitdir = {
            interval = 1000,
        },
        attach_to_untracked = false,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']h', function()
                if vim.wo.diff then return ']h' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = '[g]it next hunk' })

            map('n', '[h', function()
                if vim.wo.diff then return '[h' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = '[g]it previous hunk' })

            -- Actions
            map('n', '<leader>gR', gs.reset_buffer, { desc = 'git [R]eset buffer' })
            map('n', '<leader>gp', gs.preview_hunk, { desc = 'git [h]unk [p]review' })
        end,
    }
end)
