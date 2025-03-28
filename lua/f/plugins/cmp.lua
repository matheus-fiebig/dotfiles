return {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip' },
    opts = {
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        keymap = { preset = 'enter' },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = { documentation = { auto_show = true } },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = { sql = { 'dadbod' } },
            providers = {
                dadbod = { module = "vim_dadbod_completion.blink" },
            }
        },
        fuzzy = { implementation = "lua" }
    },
    opts_extend = { "sources.default" },
}
