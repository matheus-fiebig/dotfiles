return {
    "kevinhwang91/nvim-ufo",
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()

        vim.cmd [[nnoremap <C-f> <nop>]]
        vim.keymap.set('n', '<C-f><C-f>', require('ufo').openAllFolds)
        vim.keymap.set('n', '<C-f>', require('ufo').closeAllFolds)

        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        })
    end
}
