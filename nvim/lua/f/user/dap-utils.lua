-----------------------
--                   --
--  DOTNET COMMANDS  --
--                   --
-----------------------

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

local function run_api_dotnet(execute_previous)
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

function Build_and_run_dotnet()
    local mode = 'n'

    if vim.g['dotnet_last_dll'] ~= nil and vim.g['dotnet_last_proj_path'] ~= nil then
        mode = vim.fn.input('Execute previous steps (y/n)?')
        mode = mode:match("^%s*(.-)%s*$")
    end

    local execute_previous = mode == 'y'
    build_dotnet(execute_previous)
    return run_api_dotnet(execute_previous);
end

-----------------------
--                   --
--     GENERAL       --
--                   --
-----------------------
function Show_variable_values()
    local word_under_cursor = vim.expand("<cword>")
    Snacks.notifier(word_under_cursor, "warn")
end
