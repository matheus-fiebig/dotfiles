local table_utils = require("f.custom.utils.table")
local parser = require("f.custom.utils.parser")
local json_formatter = require("f.custom.utils.json_formatter")

---map an item to http header
---@param item table{key:string, value:string}
---@return string
local function map_to_string(item)
    return item.key .. " " .. item.value
end

---check if its allowed to concatenate the header
---@param item table
---@return boolean
local function can_use_header(item)
    return not item.disabled and item.key and item.value
end

---check if its allowed to concatenate the header
---@param headers table
---@return table
local function add_default_headers(headers)
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

---get folder or request name
---@param tbl table
---@return string
local function get_item_name(tbl)
    local name = "Request " .. tostring(tbl)
    if tbl.name then
        name = tbl.name
    end
    return name
end

---parse vars from a specific table
---@param item table | string
---@param vars table<{key: string, value: string}>
---@return table | string
local function parse_vars(item, vars)
    if type(item) == "string" then
        local found_var = table_utils.filter(function(var)
            local key = var.key ---@cast key string
            return key:find(item, 0) >= 0
        end, vars)

        if found_var then
            local result = item:gsub(found_var.key, found_var.value);
            return result
        end

        return item
    end

    local result = {}
    for key, value in pairs(vars) do
        for item_key, item_value in pairs(item) do

        end
    end

    return result
end

---@param tbl table
---@param host_env table
---@param value table
---@return string
local function create_http_template_parsed(tbl, host_env, value)
    local name = get_item_name(tbl)
    local url = value.url.raw
    local headers = add_default_headers(value.header)
    local body = get_http_body(value.body)

    local data_to_parse = {
        name = name,                                                                                                --optional
        method = value.method,                                                                                      --required
        url = parse_vars(url, host_env),                                                                            --required
        headers = table_utils.concat_to_string(parse_vars(headers, host_env), map_to_string, can_use_header, "\n"), --optional
        body = json_formatter:pretty_print(parse_vars(body, host_env))                                              --optional
    }

    local template = "###\n# {{name}}\n{{method}} {{url}}\n{{headers}}\n\n{{body}}\n\n\n"
    return parser.parse_template(template, data_to_parse)
end

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

---iterate through the itens recursively and returns all itens to be parsed into file
---@param tbl table
---@param acc_tbl table
---@return table<string>
local function iterate_through_item(tbl, acc_tbl)
    local envs = find_variables(tbl)

    local item = tbl["item"];
    if item ~= nil then
        for idx, _ in ipairs(item) do
            iterate_through_item(item[idx], acc_tbl)
        end
    end

    local req = tbl["request"]
    if req ~= nil and req.url and req.method then
        local all_envs = {}
        local req_envs = find_variables(req.url)

        if req_envs ~= nil and envs ~= nil then
            all_envs = table_utils.concat_arrays(envs, req_envs)
        elseif req_envs == nil then
            all_envs = envs
        elseif envs == nil then
            all_envs = req_envs
        end

        local result = create_http_template_parsed(tbl, all_envs, req)
        table.insert(acc_tbl, result)
    end


    return acc_tbl
end

---iterate through the itens recursively and append to file
---@param path string
---@param filename string
---@return nil
function To_http(path, filename)
    local file = io.open(path .. filename .. ".json", "r")
    local working_file = io.open(path .. filename .. ".http", "w+")

    if working_file and file then
        local file_as_json = vim.json.decode(file:read("*a"))
        local template = iterate_through_item(file_as_json, {})

        for _, value in ipairs(template) do
            if value then
                working_file:write(value)
            end
        end

        working_file:close();
        file:close();

        vim.notify("Aquivo .http gerado com sucesso em " .. path, "info")
    else
        vim.notify("Erro ao gerar arquivo .http em " .. path, "error")
    end
end
