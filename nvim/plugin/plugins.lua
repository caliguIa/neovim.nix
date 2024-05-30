local ok_wk, wk = pcall(require, 'which-key')
local ok_bigfile, bigfile = pcall(require, 'bigfile')

if not ok_wk and not ok_bigfile then return end

wk.setup()
bigfile.setup()
