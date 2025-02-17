local function define_colors()
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#b91c1c" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bold = true })

    vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        numhl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapStopped", {
        text = "🟢",
        linehl = "DapStopped",
        numhl = "DapStopped",
    })
end

vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'

    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end

    local path = vim.fn.input('Path to your *proj file', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path

    local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
    print('\nCmd to execute: ' .. cmd)

    local f = os.execute(cmd)
    if f == 0 then
        print('\nBuild: ✔️ ')
    else
        print('\nBuild: ❌ (code: ' .. f .. ')')
    end
end

vim.g.dotnet_dll = function()
    local default_path = vim.fn.getcwd() .. '/bin/Debug/'
    if vim.g['dotnet_last_dll'] ~= nil then
        default_path = vim.g['dotnet_last_dll']
    end
    vim.g['dotnet_last_dll'] = vim.fn.input('Path to your dll ', default_path, 'file')
    return vim.g['dotnet_last_dll'];
end

return {
    {
        'leoluz/nvim-dap-go',
        config = function()
            require('dap-go').setup()
        end
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local debuggers_folder = vim.fn.stdpath('data') .. "/mason"

            define_colors()

            dap.adapters.coreclr = {
                type = "executable",
                command = debuggers_folder .. "/packages/netcoredbg/netcoredbg",
                args = { "--interpreter=vscode" }
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "attach - netcoredbg",
                    request = "attach",
                    processId = require('dap.utils').pick_process,
                },
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    cwd = '${workspaceFolder}',
                    env = {
                        ASPNETCORE_ENVIRONMENT = function()
                            return "Development"
                        end,
                    },
                    program = function()
                        vim.g.dotnet_build_project()
                        return vim.g.dotnet_dll();
                    end
                }
            }
        end,
    }
}
