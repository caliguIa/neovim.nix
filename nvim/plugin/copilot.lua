local ok_copilot, copilot = pcall(require, 'copilot')

if not ok_copilot then return end

copilot.setup {
    suggestion = { enabled = true },
    panel = { enabled = false },
    filetypes = { ['*'] = true },
}

local ok_copilot_cmp, copilot_cmp = pcall(require, 'copilot-cmp')

if not ok_copilot_cmp then return end

copilot_cmp.setup {}

-- require('CopilotChat').setup {
--     debug = true,
-- }
