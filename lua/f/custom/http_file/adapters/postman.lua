local table_utils = require("f.custom.utils.table")
local parser = require("f.custom.utils.parser")
local json_formatter = require("f.custom.utils.json_formatter")

local postman = {}

---@param text string
---@param variables table
---@return string
local function repl_variables(text, variables)
    local found_variable = table_utils.filter(function(item)
        local matched = text:find(item.key, 1, true)
        return not not matched and matched > 0
    end, variables)

    if found_variable and #found_variable > 0 then
        --Remove de {{}} from de text
        local result = text:gsub(found_variable[1].key, found_variable[1].value, 1)
        return result
    end

    return text
end

--- get the tbl['variable'] in the current table
---@param tbl table
---@return table[]
local function get_variables(tbl)
    local envs = tbl['variable'];

    local predicate = function(item)
        return item['disabled'] == nil or not item['disabled']
    end

    if envs ~= nil and next(envs) ~= nil then
        envs = table_utils.filter(predicate, envs)
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
---@param variables table
---@return table
local function get_http_headers(headers, variables)
    if table_utils.is_empty(table_utils.filter(function(h) return tostring(h.key):lower() == "accept" end, headers)) then
        table.insert(headers, { key = "Accept", value = "*/*" })
    end

    if table_utils.is_empty(table_utils.filter(function(h) return tostring(h.key):lower() == "content-type" end, headers)) then
        table.insert(headers, { key = "Content-Type", value = "application/json" })
    end

    for _, header in ipairs(headers) do
        if header and header.value then
            header.value = repl_variables(header.value, variables)
        end
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

local function generate_url_encoded(url)
    if url.raw then
        return url.raw
    end

    local host = table_utils.join(url.host, "/")
    local path = table_utils.join(url.path, "/")
    local query = table_utils.join(
        url.query,
        "&",
        function(i) return i.key .. "=" .. i.value end,
        function(i) return i and not i.disabled end
    )

    return host .. "/" .. path .. "?" .. query
end


---@param request_name string
---@param request table
---@param variables table
---@return string
local function create_http_template_for(request_name, request, variables)
    local url = repl_variables(generate_url_encoded(request.url), variables)
    --TODO: pass auth object to headers
    local headers = get_http_headers(request.header, variables)
    local body = get_http_body(request.body) ---@cast body table

    local data_to_parse = {
        name = request_name,
        method = request.method,
        url = url,
        headers = table_utils.join(
            headers,
            "\n",
            function(item) return item.key .. " " .. item.value end,
            function(item) return not item.disabled and item.key and item.value end
        ),
        body = json_formatter:pretty_print(body)
    }

    local template = "###\n# {{name}}\n{{method}} {{url}}\n{{headers}}\n\n{{body}}\n\n\n"
    return parser.parse_template(template, data_to_parse)
end

---iterate through the itens recursively and returns all itens to be parsed into file
---@param tbl table
---@param acc_tbl table
---@return table<string>
local function iterate_through_item(tbl, acc_tbl, host_variables)
    local found_variables = get_variables(tbl)
    if found_variables then
        for _, value in ipairs(found_variables) do
            table.insert(host_variables, value)
        end
    end

    local item = tbl["item"];
    if item ~= nil then
        for idx, _ in ipairs(item) do
            iterate_through_item(item[idx], acc_tbl, host_variables)
        end
    end

    local req = tbl["request"]
    if req ~= nil and req.url and req.method then
        local request_variables = get_variables(req.url)
        local variables = get_unified_variables(request_variables, host_variables)
        local result = create_http_template_for(get_request_or_folder_name(tbl), req, variables)
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
    local template = iterate_through_item(file_as_json, {}, {})

    for _, value in ipairs(template) do
        if value then
            output_file:write(value)
        end
    end
end

return postman
