return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        enabled = true,
        config = function()
            require("darkvoid").setup({ glow = true })
        end,
    },
    {
        '0xstepit/flow.nvim',
        config = function()
            require("flow").setup({
                colors = {
                    mode = "default",
                    fluo = "pink",
                },
            })
        end
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
}
