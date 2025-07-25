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
        'folke/trouble.nvim',
        config = function()
            require('trouble').setup({
                icons = {
                    indent = {
                        middle = " ",
                        last = " ",
                        top = " ",
                        ws = "│  ",
                    },
                },
                modes = {
                    diagnostics = {
                        groups = {
                            { "filename", format = "{file_icon} {basename:Title} {count}" },
                        },
                        preview = {
                            type = "float",
                            relative = "editor",
                            border = "rounded",
                            title = "Preview",
                            title_pos = "center",
                            position = { 0, -2 },
                            size = { width = 0.3, height = 0.3 },
                            zindex = 200,
                        },
                    },
                },
            })
        end,
    }
}
