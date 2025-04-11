return {
    'nvim-tree/nvim-web-devicons',
    'DaikyXendo/nvim-material-icon',
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        init = function() vim.g.barbar_auto_setup = false end,
        config = function()
            require 'barbar'.setup {}
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = require 'lualine.themes.powerline_dark',
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
                    lualine_b = { 'branch', },
                    lualine_x = {},
                    lualine_y = { 'filetype', 'progress' },
                    lualine_z = {
                        { 'location', separator = { right = '' }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { 'location' },
                },
            })
        end
    },
    {
        'neanias/everforest-nvim',
        config = function()
            vim.cmd("colorscheme everforest")
        end
    },
    {
        'bgwdotdev/gleam-theme-nvim',
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
        opts = {
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
