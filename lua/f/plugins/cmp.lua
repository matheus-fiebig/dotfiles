return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip', 'giuxtaposition/blink-cmp-copilot' },
        opts = {
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            keymap = { preset = 'super-tab' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = { 'lsp', 'buffer', 'path', 'snippets', "copilot" },
                per_filetype = { sql = { 'dadbod' } },
                providers = {
                    dadbod = { module = "vim_dadbod_completion.blink" },
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                }
            },
            fuzzy = { implementation = "lua" }
        },
        opts_extend = { "sources.default" },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    }
}
