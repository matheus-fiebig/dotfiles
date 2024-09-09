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
    --{
    --'neanias/everforest-nvim',
    --config = function()
    --vim.cmd("colorscheme everforest")
    --end,
    --}
    --{
        --'bgwdotdev/gleam-theme-nvim',
        --config = function()
            --vim.cmd("colorscheme gleam")
        --end,
    --},
    --{
    --'ribru17/bamboo.nvim',
    --config = function()
    --vim.cmd("colorscheme bamboo")
    --end,
    --}
    --{
    --'ricardoraposo/gruvbox-minor.nvim',
    --config = function()
    --vim.cmd("colorscheme gruvbox-minor")
    --end,
    --}
    --{
    --'luisiacc/handmade-hero-theme',
    --config = function()
    --vim.cmd("colorscheme handmade-hero-theme")
    --end,
    --}
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine-moon")
        end,
    },
    --{
        --"AlanWarren/rocket",
        --config = function()
            --vim.cmd("colorscheme rocket")
        --end,
    --}
}
