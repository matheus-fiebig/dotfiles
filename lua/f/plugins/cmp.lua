return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip' },
        opts = {
            appearance = {
                nerd_font_variant = 'mono',
                kind_icons = {
                    Text = '  ',
                    Method = '  ',
                    Function = '  ',
                    Constructor = '  ',
                    Field = '  ',
                    Variable = '  ',
                    Class = '  ',
                    Interface = '  ',
                    Module = '  ',
                    Property = '  ',
                    Unit = '  ',
                    Value = '  ',
                    Enum = '  ',
                    Keyword = '  ',
                    Snippet = '  ',
                    Color = '  ',
                    File = '  ',
                    Reference = '  ',
                    Folder = '  ',
                    EnumMember = '  ',
                    Constant = '  ',
                    Struct = '  ',
                    Event = '  ',
                    Operator = '  ',
                    TypeParameter = '  '
                },
            },
            completion = {
                documentation = { auto_show = true },
                menu = {
                    draw = {
                        components = {
                        },
                    }
                },
            },
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
                    lsp = {
                        min_keyword_length = 0,
                        score_offset = 0,
                    },
                    path = {
                        min_keyword_length = 1,
                        score_offset = 2,
                    },
                    buffer = {
                        min_keyword_length = 1,
                        score_offset = 3,
                    },
                    snippets = {
                        min_keyword_length = 1,
                        score_offset = 4,
                    }
                },
            },
            cmdline = { enabled = false },
            signature = { enabled = true },
            keymap = {
                ["<C-space>"] = { "show", 'show_documentation', 'hide_documentation' },
                ["<C-c>"] = { "hide" },
                ["<CR>"] = { "select_and_accept", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
            },
            fuzzy = { implementation = "lua" },
        },
        opts_extend = { "sources.default" },
    }
    --,{
        --"zbirenbaum/copilot.lua",
        --cmd = "Copilot",
        --event = "InsertEnter",
        --config = function()
            --require("copilot").setup({
                --suggestion = { enabled = false },
                --panel = { enabled = false },
            --})
        --end,
    --}
}
