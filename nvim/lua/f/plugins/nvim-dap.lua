return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require('dap')
    local debuggers_folder = vim.fn.stdpath('data') .. "/mason"

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
            return "Local"
          end,
          --ASPNETCORE_URLS = function()
            --return "http://localhost:5050"
          --end,
        },
        program = function() --To launch a project update the line bellow or add a dap-per-project
          local path = vim.fn.getcwd()
          local projectName = path:match("[^/]+$")
          return vim.fn.input('', path .. '/bin/Debug/net8.0/' .. projectName .. '.dll', 'file')
        end
      }
    }
  end,
}
