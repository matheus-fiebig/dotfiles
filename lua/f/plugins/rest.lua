local disable = true

if disable or (vim.version().major == 0 and vim.version().minor <= 10 and vim.version().patch < 4) then
    return {}
end

return {
    "rest-nvim/rest.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, "http")
        end,
    }
}
