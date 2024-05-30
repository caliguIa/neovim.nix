local ok_persistence, persistence = pcall(require, 'persistence')

if not ok_persistence then return end

persistence.setup {
    options = vim.opt.sessionoptions:get(),
}
