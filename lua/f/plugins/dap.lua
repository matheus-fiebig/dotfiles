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
                        return Build_and_run_dotnet();
                    end
                }
            }
        end,
    }
}
