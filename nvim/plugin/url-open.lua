local ok_url_open, url_open = pcall(require, 'url-open')

if not ok_url_open then return end

url_open.setup()

vim.keymap.set('n', 'gx', '<ESC>:URLOpenUnderCursor<CR>', { desc = 'Open URL' })
