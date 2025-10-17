vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#c8ffa7", fg = "#292d3e" })
        vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200, visual = true })
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Restore dotnet project",
    callback = function()
        local handle = io.popen("find . -name '*.sln' -print -quit")
        if handle == nil then
            return
        end

        local sln_file = handle:read("*a")
        handle:close()
        sln_file = sln_file:gsub("%s+", "")

        if sln_file and sln_file ~= "" then
            os.execute("dotnet restore " .. sln_file)
            Snacks.notify.info("Packages restored for " .. sln_file, { timeout = 5000, title = "Restore Info" })
        else
            Snacks.notify.info("No solutions found ", { timeout = 5000, title = "Restore Info" })
        end
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
