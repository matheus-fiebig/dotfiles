return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local ok, luasnip = pcall(require, 'luasnip.loaders.from_vscode')

    if ok then
      luasnip.lazy_load()
    end

    local cmp = require('cmp')
    cmp.setup({
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
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
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
      },
      formatting = {
        format = function(entry, vim_item)
          -- set a name for each source
          vim_item.menu = ({
            luasnip  = "[SNIP]",
            nvim_lsp = "[LSP]",
            buffer   = "[BUFF]",
            path     = "[PATH]"
          })[entry.source.name]

          return vim_item
        end,
      },
    })
  end
}
