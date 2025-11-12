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
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "Issafalcon/lsp-overloads.nvim"
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

            local lspconfig = require("lspconfig")

            lspconfig.ts_ls.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            }

            lspconfig.angularls.setup {}

            lspconfig.roslynv4.setup {
                filetypes = { 'cs' }
            }

            lspconfig.lua_ls.setup {
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
            }

            lspconfig.gdscript.setup({})
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
