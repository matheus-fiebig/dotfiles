return {
    {
        'easymotion/vim-easymotion'
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    {
        "airblade/vim-rooter"
    },
    {
        "preservim/nerdcommenter",
    },
    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup({
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    --vim.keymap.set("n", "", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    --vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            })
        end
    }
}

