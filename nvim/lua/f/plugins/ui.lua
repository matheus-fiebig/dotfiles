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
        config = function()
            --vim.cmd("colorscheme everforest")
        end,
    },
    {
        'bgwdotdev/gleam-theme-nvim',
        config = function()
           --vim.cmd("colorscheme gleam")
        end,
    },
    {
        'ribru17/bamboo.nvim',
        config = function()
            --vim.cmd("colorscheme bamboo")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            --vim.cmd("colorscheme rose-pine-moon")
            --vim.cmd("colorscheme rose-pine-dawn")
        end,
    },
    {
        "AlanWarren/rocket",
        config = function()
            --vim.cmd("colorscheme rocket")
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            --vim.cmd("colorscheme tokyonight-storm")
            --vim.cmd("colorscheme tokyonight-day")
        end,
    },
    {
        "gbprod/nord.nvim",
        config = function()
            vim.cmd("colorscheme nord")
        end,
    }
}
