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
    local mason_registry = require('mason-registry')

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
    }

    lspconfig.tsserver.setup {
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
            languages = { 'vue' },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    }

    lspconfig.volar.setup {}
    lspconfig.angularls.setup{}
  end
}
