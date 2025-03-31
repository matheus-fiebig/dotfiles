local table_utils = require("f.custom.utils.table")
local parser = require("f.custom.utils.parser")
local json_formatter = require("f.custom.utils.json_formatter")

local postman = {}

--- get the tbl['variable'] in the current table
---@param tbl table
---@return table[]
local function find_variables(tbl)
    local envs = tbl['variable'];

    if envs ~= nil and next(envs) ~= nil then
        envs = table_utils.filter(function(item)
            return item['disabled'] == nil or not item['disabled']
        end, envs)
    end

    return envs
end

local function get_unified_variables(request_variables, host_variables)
    local all_envs = {}
    if request_variables ~= nil and host_variables ~= nil then
        all_envs = table_utils.concat_arrays(host_variables, request_variables)
    elseif request_variables == nil then
        all_envs = host_variables
    elseif host_variables == nil then
        all_envs = request_variables
    end
    return all_envs
end

---get folder or request name
---@param tbl table
---@return string
local function get_request_or_folder_name(tbl)
    local name = "Request " .. tostring(tbl)
    if tbl.name then
        name = tbl.name
    end
    return name
end

---check if its allowed to concatenate the header
---@param headers table
---@return table
local function get_http_headers(headers)
    if table_utils.is_empty(table_utils.filter(function(h) return tostring(h.key):lower() == "accept" end, headers)) then
        table.insert(headers, { key = "Accept", value = "*/*" })
    end

    if table_utils.is_empty(table_utils.filter(function(h) return tostring(h.key):lower() == "content-type" end, headers)) then
        table.insert(headers, { key = "Content-Type", value = "application/json" })
    end

    return headers
end

---check if its allowed to concatenate the header
---@param request table
---@return table | nil
local function get_http_body(request)
    if request.body == nil or not table_utils.is_empty(request.body) then
        return {}
    end

    local raw_value = request.body.raw
    if raw_value then
        return raw_value
    end

    return nil
end

---@param tbl table
---@param host_env table
---@param value table
---@return string
local function create_http_template_for_item(tbl, host_env, value)
    local name = get_request_or_folder_name(tbl)
    local url = value.url.raw
    local headers = get_http_headers(value.header)
    local body = get_http_body(value.body) ---@cast body table

    local data_to_parse = {
        name = name,
        method = value.method,
        url = parser.parse_variables(url, host_env),
        headers = table_utils.concat_to_string(headers,
            function(item) return item.key .. " " .. item.value end,
            function(item) return not item.disabled and item.key and item.value end, "\n"),
        body = json_formatter:pretty_print(body)
    }

    local template = "###\n# {{name}}\n{{method}} {{url}}\n{{headers}}\n\n{{body}}\n\n\n"
    return parser.parse_template(template, data_to_parse)
end

---iterate through the itens recursively and returns all itens to be parsed into file
---@param tbl table
---@param acc_tbl table
---@return table<string>
local function iterate_through_item(tbl, acc_tbl)
    local host_variables = find_variables(tbl)

    local item = tbl["item"];
    if item ~= nil then
        for idx, _ in ipairs(item) do
            iterate_through_item(item[idx], acc_tbl)
        end
    end

    local req = tbl["request"]
    if req ~= nil and req.url and req.method then
        local request_variables = find_variables(req.url)
        local variables = get_unified_variables(request_variables, host_variables)
        local result = create_http_template_for_item(tbl, variables, req)
        table.insert(acc_tbl, result)
    end

    return acc_tbl
end

---iterate through the itens recursively and append to file
---@param json_file file*
---@param output_file file*
---@return nil
postman.generate = function(json_file, output_file)
    local file_as_json = vim.json.decode(json_file:read("*a"))
    local template = iterate_through_item(file_as_json, {})

    for _, value in ipairs(template) do
        if value then
            output_file:write(value)
        end
    end
end

return postman
