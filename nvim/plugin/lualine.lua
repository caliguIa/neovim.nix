local ok_lualine, lualine = pcall(require, 'lualine')

if not ok_lualine then return end

local icons = require 'user.icons'
local diagnostics_icons = require('user.icons').diagnostics

local diagnostics = {
    'diagnostics',
    sections = { 'error', 'warn' },
    colored = true, -- Displays diagnostics status in color if set to true.
    always_visible = true, -- Show diagnostics even if there are none.
    symbols = {
        error = diagnostics_icons.ERROR,
        warn = diagnostics_icons.WARN,
        hint = diagnostics_icons.HINT,
        info = diagnostics_icons.INFO,
    },
}

local diff = {
    'diff',
    source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
            return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
            }
        end
    end,
    symbols = {
        added = icons.git.LineAdded .. ' ',
        modified = icons.git.LineModified .. ' ',
        removed = icons.git.LineRemoved .. ' ',
    },
    colored = true,
    always_visible = true,
}

local function getLspName()
    local buf_clients = vim.lsp.get_active_clients()
    local buf_ft = vim.bo.filetype
    if next(buf_clients) == nil then return '  No servers' end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= 'null-ls' then table.insert(buf_client_names, client.name) end
    end

    local lint_s, lint = pcall(require, 'lint')
    if lint_s then
        for ft_k, ft_v in pairs(lint.linters_by_ft) do
            if type(ft_v) == 'table' then
                for _, linter in ipairs(ft_v) do
                    if buf_ft == ft_k then table.insert(buf_client_names, linter) end
                end
            elseif type(ft_v) == 'string' then
                if buf_ft == ft_k then table.insert(buf_client_names, ft_v) end
            end
        end
    end

    local ok, conform = pcall(require, 'conform')
    local formatters = table.concat(conform.list_formatters_for_buffer(), ' ')
    if ok then
        for formatter in formatters:gmatch '%w+' do
            if formatter then table.insert(buf_client_names, formatter) end
        end
    end

    local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            if v ~= 'copilot' then
                unique_client_names[#unique_client_names + 1] = v
                hash[v] = true
            end
        end
    end
    local language_servers = table.concat(unique_client_names, ', ')

    return language_servers
end

local lsp = {
    function() return getLspName() end,
}

lualine.setup {
    extensions = { 'trouble' },
    sections = {
        lualine_a = { 'branch' },
        lualine_b = { 'filename' },
        lualine_c = { 'overseer' },
        lualine_x = {
            lsp,
            'copilot',
            'progress',
            diff,
            diagnostics,
        },
        lualine_y = {},
        lualine_z = {},
    },
    options = {
        icons_enabled = false,
        theme = 'tokyonight',
        disabled_filetypes = { 'oil', 'DashboardLoaded', 'dashboard' },
        component_separators = '',
        section_separators = '',
    },
}
