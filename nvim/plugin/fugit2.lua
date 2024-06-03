require('fugit2').setup {
    libgit2_path = '/nix/store/pzzzz8b7mayy5p965biadxr3nhhivy9v-libgit2-1.7.2-lib/lib/libgit2.1.7.2.dylib',
    width = 70,
    external_diffview = true,
}

vim.keymap.set('n', '<leader>G', '<cmd>Fugit2<cr>', { noremap = true, silent = true, desc = '[f]ugit2 open' })
