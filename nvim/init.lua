local cmd = vim.cmd
local opt = vim.o
local g = vim.g

-- <leader> key. Defaults to `\`. Some people prefer space.
-- g.mapleader = ' '
-- g.maplocalleader = ' '
g.mapleader = ' '
g.maplocalleader = ' '
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.compatible = false

-- Search down into subfolders
opt.path = vim.o.path .. '**'

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.lazyredraw = true
opt.showmatch = true -- Highlight matching parentheses, etc
opt.incsearch = true
opt.hlsearch = true

opt.spell = false
opt.spelllang = 'en'

opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.foldenable = true
opt.history = 2000
opt.nrformats = 'bin,hex' -- 'octal'
opt.undofile = true
opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
opt.splitright = true
opt.splitbelow = true
opt.cmdheight = 0

opt.inccommand = 'split'
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.breakindent = true
opt.autoread = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 10
opt.updatetime = 50
opt.timeout = true
opt.timeoutlen = 300
opt.completeopt = 'menuone,noselect'
opt.termguicolors = true
opt.swapfile = false
opt.wrap = false
opt.showmode = false

vim.opt.formatoptions:remove 'o'

vim.diagnostic.config {
    virtual_text = false,
    signs = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'single',
        source = 'if_many',
        header = '',
        prefix = '',
    },
}

g.editorconfig = true

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd 'cfilter' -- Allows filtering the quickfix list with :cfdo
