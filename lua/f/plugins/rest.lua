if (vim.version().major == 0 and vim.version().minor <= 10 and vim.version().patch < 0) then
    return {}
end

return {
    "mistweaverco/kulala.nvim",
    keys = {},
    ft = { "http", "rest" },
    opts = {
        -- your configuration comes here
        additional_curl_options = { "--insecure" },
        global_keymaps = false,
    },
}
