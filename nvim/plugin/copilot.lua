require('copilot').setup {
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept = '<C-a>',
            accept_word = '<C-s>',
            accept_line = '<C-d>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
        },
    },
}

require('CopilotChat').setup {
    debug = true,
}
