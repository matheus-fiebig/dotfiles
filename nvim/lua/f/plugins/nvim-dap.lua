vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
    print('')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print('\nBuild: ✔️ ')
    else
        print('\nBuild: ❌ (code: ' .. f .. ')')
    end
end

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
        name = "launch - from parent workspaceFolder",
        request = "launch",
        cwd = '${workspaceFolder}',
        env = {
          ASPNETCORE_ENVIRONMENT = function()
            return "Local"
          end,
          ASPNETCORE_URLS = function()
            return "http://localhost:80"
          end,
        },
        program = function() --To launch a project update the line bellow or add a dap-per-project
          vim.g.dotnet_build_project()
          local path = vim.fn.getcwd()
          local projectName = path:match("[^/]+$")
          return vim.fn.input('', path .. '/bin/Debug/net8.0/' .. projectName .. '.dll', 'file')
        end
      },
      {
        type = "coreclr",
        name = "launch - Nimbus API",
        request = "launch",
        env = {
          ASPNETCORE_ENVIRONMENT = function()
            return "Local"
          end,
          ASPNETCORE_URLS = function()
            return "http://localhost:80"
          end,
        },
        program = function()
          vim.g.dotnet_build_project()
          local path = '/root/repos_newsat/newsat-cloud-api/src/Adapters/Raizen.NewSatCloud.API/bin/Debug/net8.0/Raizen.NewSatCloud.API.dll'
          return vim.fn.input('',  path, 'file')
        end
      }
    }
  end,
}
