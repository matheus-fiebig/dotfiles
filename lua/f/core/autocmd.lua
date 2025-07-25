vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#c8ffa7", fg = "#292d3e" })
        vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200, visual = true })
    end,
})


vim.api.nvim_create_user_command('KulalaSendRequest', function(_)
    require("kulala").run()
end, {})

vim.api.nvim_create_user_command('KulalaScratchpad', function(_)
    require("kulala").scratchpad()
end, {})

vim.api.nvim_create_user_command('LspToggleHints', function(_)
    local enabled = not vim.lsp.inlay_hint.is_enabled({})
    vim.lsp.inlay_hint.enable(enabled)
    vim.notify("Inlay hints: " .. (enabled and " on" or "off"))
end, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*.cs",
    callback = function()
        local current_buf_path = vim.api.nvim_buf_get_name(0)
        if current_buf_path == "" then
            current_buf_path = vim.fn.getcwd()
        end
        local start_path = vim.fn.fnamemodify(current_buf_path, ":h")
        local sln_files = vim.fs.find(
            function(name, _) return name:match('%.sln$') ~= nil end,
            { upward = true, path = start_path, type = 'file' }
        )
        vim.fn.system("dotnet build " .. sln_files[1])
    end,
})
