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
            require("aerial").setup({})
        end
    }
}
