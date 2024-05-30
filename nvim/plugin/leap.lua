local ok_leap, leap = pcall(require, 'leap')
local ok_flit, flit = pcall(require, 'flit')

if not ok_leap and not ok_flit then return end

leap.setup()
leap.add_default_mappings(true)

flit.setup {
    labelled_mode = 'nx',
}
