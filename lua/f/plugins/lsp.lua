return {
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
        config = function()
            vim.lsp.config("roslyn", {
                settings = {
                },
            })
            local roslyn = require("roslyn")
            roslyn.setup()
        end,
    },
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "Issafalcon/lsp-overloads.nvim",
            "neovim/nvim-lspconfig"
        },
        config = function()
            require("mason").setup({
                registries = {
                    'github:Crashdummyy/mason-registry',
                    'github:mason-org/mason-registry',
                },
            })
            require("mason-lspconfig").setup({
                automatic_installation = true
            })

            local lspconfig = vim.lsp

            lspconfig.config("ts_ls", {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            })

            lspconfig.config("angularls", {
                filetypes = { 'typescript', 'javascript' },
            })

            lspconfig.config("roslynv4", {
                filetypes = { 'cs' }
            })

            lspconfig.config("lua_ls", {
                filetypes = { 'lua' },
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {
                                'vim',
                                'require'
                            },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })


            lspconfig.config("lua_ls", {
                filetypes = { 'gdscript' }
            })
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                gdscript = { 'gdformat' },
            },
        },
    }
}
