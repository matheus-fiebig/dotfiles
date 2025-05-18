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
            local dapui = require('dapui')
            local debuggers_folder = vim.fn.stdpath('data') .. "/mason"

            -- automatically setup dap ui
            --dap.listeners.after.event_initialized["dapui_config"] = function()
            --dapui.open {}
            --end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close {}
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close {}
            end

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
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup({
                controls = {
                    element = "repl",
                    enabled = true,
                    icons = {
                        disconnect = "",
                        pause = "",
                        play = "",
                        run_last = "",
                        step_back = "",
                        step_into = "",
                        step_out = "",
                        step_over = "",
                        terminate = ""
                    }
                },
                element_mappings = {},
                expand_lines = true,
                floating = {
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" }
                    }
                },
                force_buffers = true,
                icons = {
                    collapsed = "",
                    current_frame = "",
                    expanded = ""
                },
                layouts = {
                    {
                        elements = {
                            {
                                id = "repl",
                                size = 1
                            }
                        },
                        position = "bottom",
                        size = 10
                    },
                    {
                        elements = {
                            {
                                id = "scopes",
                                size = 1
                            },
                        },
                        position = "left",
                        size = 30
                    }
                },
                mappings = {
                    edit = "e",
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    repl = "r",
                    toggle = "t"
                },
                render = {
                    indent = 1,
                    max_value_lines = 100
                }
            }
            )
        end,
        keys = {
            {
                "<leader>dui",
                function()
                    require('dapui').toggle()
                end,
                "Toggle dapui"
            }
        }
    }
}
