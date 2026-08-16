return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        enabled = true,
        config = function()
            require("everforest").setup({ glow = true })
        end,
    },
    {
        "ntk148v/slack.nvim"
    },
    {
        'neanias/everforest-nvim',
    },
    {
        "gbprod/nord.nvim",
    },
    {
        "masisz/wisteria.nvim"
    },
    {
        'mphe/vim-gdscript4'
    }
}
