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
        program = function()
          return vim.fn.input('', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end
      }
    }

 end,
  
}
