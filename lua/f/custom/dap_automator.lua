---@param path_str string
---@return string | nil
local function abs_path(path_str)
    local safe_path = path_str:gsub('"', '\\"')
    local command = 'realpath "' .. safe_path .. '"'

    local handle = io.popen(command)
    if not handle then
        print("Erro ao executar o comando 'realpath'. Verifique se ele está instalado.")
        return nil
    end

    local path = handle:read("*a"):gsub("[\r\n]", "")

    handle:close()

    if abs_path == "" then
        return nil
    end

    return path
end

---@param filename string
---@return string
local function find_file(filename)
    local command = 'find . -type f -name "' .. filename .. '" -print -quit'
    local handle = io.popen(command)

    if not handle then
        error("could not handle the command", 3)
    end

    local filepath = handle:read("*a"):gsub("[\r\n]", "")
    handle:close()

    return filepath
end

---@param some_file_path string
---@return string
local function find_csproj_alongside(some_file_path)
    local dir_command = 'dirname "' .. some_file_path .. '"'
    local dir_handle = io.popen(dir_command)
    if not dir_handle then
        error("directory could be opened", 3)
    end

    local directory = dir_handle:read("*a"):gsub("[\r\n]", "")
    dir_handle:close()

    if not directory or directory == "" then
        error("directory not found", 3)
    end

    local csproj_command = 'find "' .. directory .. '" -maxdepth 1 -type f -name "*.csproj" -print -quit'
    local csproj_handle = io.popen(csproj_command)
    if not csproj_handle then
        error("csproj could not be opened", 3)
    end

    local csproj_path = csproj_handle:read("*a"):gsub("[\r\n]", "")
    csproj_handle:close()
    return csproj_path
end

---@param csproj_path string
---@return string
local function get_dotnet_version(csproj_path)
    local file = io.open(csproj_path, "r")
    if not file then
        Snacks.notifier("Could not open file: " .. csproj_path, "error")
        return '';
    end

    local content = file:read("*a")
    file:close()

    local targetFramework = content:match("<TargetFramework>(.-)</TargetFramework>")
    return targetFramework
end

---@return table
local function build_dotnet()
    local program_path = find_file("Program.cs")
    local local_csproj_path = find_csproj_alongside(program_path)
    local abs_csproj_path = abs_path(local_csproj_path)
    local cmd = 'dotnet build -c Debug ' .. abs_csproj_path .. ' > /dev/null'
    local execution_code = os.execute(cmd)
    local path = tostring(abs_csproj_path)
    return {
        status = execution_code,
        filename = path:match("^(.*)%.([^%.]+)$"):match("([^/]+)$"),
        csproj_path = path,
        csproj_folder = path:match("^(.*)%.([^%.]+)$"):match("^(.*)/")
    }
end

---@param build_data table
---@return string
local function run_dotnet_api(build_data)
    local target_framework = get_dotnet_version(build_data.csproj_path)
    local dll_path = build_data.csproj_folder ..
        '/bin/Debug/' .. target_framework .. '/' .. build_data.filename .. '.dll'
    return dll_path;
end

---@return string
function Build_and_run_dotnet()
    local build_data = build_dotnet()
    if tostring(build_data.status) == '0' then
        Snacks.notify.info('Build succeded with status code ' .. build_data.status,
            { timeout = 5000, title = "On Build" })
    else
        Snacks.notify.error('Build error with status code ' .. build_data.status, { timeout = 5000, title = "On Build" })
        vim.diagnostic.setqflist()
        return ""
    end

    local dll = run_dotnet_api(build_data)
    Snacks.notify.info('Debugging file ' .. build_data.filename, { timeout = 5000, title = "On Run" })
    return dll
end
