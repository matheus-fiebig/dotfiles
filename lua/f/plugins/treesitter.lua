return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require('nvim-ts-autotag').setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      ensure_installed = {
        "json",
        "angular",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "c_sharp",
        "sql",
        "css",
        "go",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })

  end,
}
