local plugins = {
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = true
    }
}

if vim.fn.executable("gh") == 1 then
    table.insert(plugins, {
        'pwntester/octo.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require "octo".setup()
        end
    })
end


return plugins
