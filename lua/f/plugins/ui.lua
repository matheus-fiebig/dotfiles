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
    },
    {
        'ribru17/bamboo.nvim',
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        "AlanWarren/rocket",
    },
    {
        "folke/tokyonight.nvim",
    },
    {
        "gbprod/nord.nvim",
        config = function()
            vim.cmd("colorscheme nord")
        end
    }
}
