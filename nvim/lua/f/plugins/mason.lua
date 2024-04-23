return {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "Issafalcon/lsp-overloads.nvim"
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_installation = true
            })

            local lspconfig = require("lspconfig")

            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    lspconfig[server_name].setup {
                        on_attach = function(client)
                            if client.server_capabilities.signatureHelpProvider then
                                require('lsp-overloads').setup(client, {})
                            end
                        end
                    }
                end,

                ["omnisharp_mono"] = function()
                    lspconfig["omnisharp_mono"].setup {
                        on_attach = function(client)
                            require('lsp-overloads').setup(client, {})
                        end
                    }
                end,

            }
        end
}
