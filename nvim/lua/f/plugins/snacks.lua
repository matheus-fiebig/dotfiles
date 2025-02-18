return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            actions = {
                toggle_cwd = function(p)
                    local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
                    local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
                    local current = p:cwd()
                    p:set_cwd(current == root and cwd or root)
                    p:find()
                end
            },
        },
    },
}
