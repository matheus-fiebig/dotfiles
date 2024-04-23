return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
    },
    config = function()
            local cmp = require('cmp')
            cmp.setup({
                preselect = cmp.PreselectMode.None,
                mapping = {
                    ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end),
                    ['<S-Tab>'] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        end
                    end),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }
            })
    end
}
