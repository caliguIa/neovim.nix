local ok_ts_configs, ts_configs = pcall(require, 'nvim-treesitter.configs')
if not ok_ts_configs then return end

vim.g.skip_ts_context_comment_string_module = true

---@diagnostic disable-next-line: missing-fields
ts_configs.setup {
    indent = { enable = false },
    ensure_installed = {},
    ignore_install = {},
    sync_install = false,
    auto_install = false,
    rainbow = {
        enable = true,
    },
    highlight = {
        enable = true,
        max_file_lines = 5000,
        disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KiB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            return stats and stats.size > max_filesize
        end,
    },
}

local ok_ts_context, ts_context = pcall(require, 'treesitter-context')
if not ok_ts_context then return end

ts_context.setup {
    max_lines = 3,
}

local ok_tabout, tabout = pcall(require, 'tabout')
if not ok_tabout then return end

tabout.setup {
    tabkey = '<Tab>',
    backwards_tabkey = '<S-Tab>',
    completion = false,
}

local ok_ts_autotag, ts_autotag = pcall(require, 'nvim-ts-autotag')
if not ok_ts_autotag then return end

ts_autotag.setup {
    opts = {
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,

        filetypes = {
            'html',
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            'tsx',
            'jsx',
            'xml',
            'php',
            'markdown',
        },
    },
}

local ok_ts_comments, ts_comments = pcall(require, 'ts-comments')
if not ok_ts_comments then return end

ts_comments.setup {}
