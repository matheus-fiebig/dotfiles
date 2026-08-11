return {
    'nvim-tree/nvim-web-devicons',

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        init = function() vim.g.barbar_auto_setup = false end,
        config = function()
            require 'barbar'.setup {
                icons = {
                    modified = { button = 'M' },
                },
            }
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
        "folke/noice.nvim",
        event = "Verylazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
        config = function()
            require("noice").setup({
                view = "cmdline",
                cmdline = {
                    format = {
                        search_down = {
                            view = "cmdline",
                        },
                        search_up = {
                            view = "cmdline",
                        },
                    },
                },
                lsp = {
                    progress = { enabled = true },
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                }
            })
        end
    },
}
