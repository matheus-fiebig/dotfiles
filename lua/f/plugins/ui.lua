return {
    'nvim-tree/nvim-web-devicons',
    'DaikyXendo/nvim-material-icon',
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = { theme = require 'lualine.themes.dracula' }
            })
        end
    },
    {
        'neanias/everforest-nvim',
    },
    {
        'bgwdotdev/gleam-theme-nvim',
        config = function()
            vim.cmd("colorscheme gleam")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        "folke/tokyonight.nvim",
    },
    {
        "gbprod/nord.nvim",
    }
}
