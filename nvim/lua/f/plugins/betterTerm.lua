return {
  "CRAG666/betterTerm.nvim",
  config = function()
    local betterTerm = require('betterTerm')
    betterTerm.setup()
    vim.keymap.set({"n", "t"}, "<leader>t", betterTerm.open, { desc = "Open terminal"})
  end
}
