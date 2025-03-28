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
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        opt = {
            notifier = {
                style = "compact"
            }
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            local nvimtree = require("nvim-tree")

            -- recommended settings from nvim-tree documentation
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            nvimtree.setup({
                view = {
                    width = 45,
                    relativenumber = true,
                },
                -- change folder arrow icons
                renderer = {
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        glyphs = {
                            folder = {
                                arrow_closed = "", -- arrow when folder is closed
                                arrow_open = "", -- arrow when folder is open
                            },
                        },
                    },
                },
                -- disable window_picker for
                -- explorer to work well with
                -- window splits
                actions = {
                    open_file = {
                        window_picker = {
                            enable = false,
                        },
                    },
                },
                filters = {
                    custom = { ".DS_Store" },
                },
                git = {
                    ignore = false,
                },
            })
        end
    }
}
