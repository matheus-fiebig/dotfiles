vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#c8ffa7", fg = "#292d3e" })
        vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200, visual = true })
    end,
})
