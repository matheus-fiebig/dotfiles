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

local function get_dotnet_version(file_path)
    local file = io.open(file_path, "r")
    if not file then
        Snacks.notifier("Could not open file: " .. file_path, "error")
        return '';
    end

    local content = file:read("*a")
    file:close()

    local targetFramework = content:match("<TargetFramework>(.-)</TargetFramework>")
    return targetFramework
end

---@param execute_previous boolean
local function build_dotnet(execute_previous)
    local default_path = vim.fn.getcwd() .. '/'

    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end

    if not execute_previous then
        local path = vim.fn.input('Path to your *proj file', default_path, 'file')
        vim.g['dotnet_last_proj_path'] = path
    end

    local cmd = 'dotnet build -c Debug ' .. default_path .. ' > /dev/null'
    Snacks.notifier('\nCmd to execute: ' .. cmd, "info")

    local f = os.execute(cmd)
    Snacks.notifier('Build finished with code ' .. f, "info")
end

---@param execute_previous boolean
local function getdll_dotnet(execute_previous)
    local csproj_path = vim.g['dotnet_last_proj_path']
    local _, filename = csproj_path:match("(.+)[/\\]([^/\\]+)%.csproj$")
    local target_framework = get_dotnet_version(csproj_path)
    local default_path = vim.fn.getcwd() .. '/bin/Debug/' .. target_framework .. '/' .. filename .. '.dll'

    if vim.g['dotnet_last_dll'] ~= nil then
        default_path = vim.g['dotnet_last_dll']
    end

    if not execute_previous then
        vim.g['dotnet_last_dll'] = vim.fn.input('Path to your dll ', default_path, 'file')
    end

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
                        local mode = 'n'

                        if vim.g['dotnet_last_dll'] ~= nil and vim.g['dotnet_last_proj_path'] ~= nil then
                            mode = vim.fn.input('Execute previous steps (y/n)?')
                            mode = mode:match("^%s*(.-)%s*$")
                        end

                        local execute_previous = mode == 'y'
                        build_dotnet(execute_previous)
                        return getdll_dotnet(execute_previous);
                    end
                }
            }
        end,
    }
}
