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
    },
    {
        "gelguy/wilder.nvim",
        config = function()
            local wilder = require("wilder")
            wilder.setup({ modes = { ":", "/", "?" } })
            wilder.set_option('use_python_remote_plugin', 0)

            wilder.set_option("pipeline", {
                wilder.branch(
                    wilder.cmdline_pipeline({
                        fuzzy = 1,
                    }),
                    wilder.vim_search_pipeline({
                        fuzzy = 1,
                    })
                ),
            })

            wilder.set_option(
                "renderer",
                wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                    highlighter = wilder.basic_highlighter(),
                    pumblend = 5,
                    min_width = "100%",
                    min_height = "25%",
                    max_height = "35%",
                    border = "rounded",
                    left = { " ", wilder.popupmenu_devicons() },
                    right = { " ", wilder.popupmenu_scrollbar() },
                }))
            )
        end
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opt = {
            notifier = {
                style = "compact"
            }
        }
    }
}
