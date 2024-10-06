local ok_tokyonight, tokyonight = pcall(require, 'tokyonight')

if not ok_tokyonight then return end

tokyonight.setup {
    style = 'night',
}

vim.cmd [[colorscheme tokyonight]]
