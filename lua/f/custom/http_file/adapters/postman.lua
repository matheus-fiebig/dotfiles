local table_utils = require("f.custom.utils.table")
local parser = require("f.custom.utils.parser")
local json_formatter = require("f.custom.utils.json_formatter")

local postman = {}

---@param item PostmanVariable
---@return boolean
local predicate = function(item)
    return item['disabled'] == nil or not item['disabled']
end

---@param item PostmanVariable
---@return PostmanVariable
local padronize = function(item)
    local key = item.key ---@cast key string
    if not key:match("^{{") then
        key = "{{" .. key
    end
    if not key:match("}}$") then
        key = key .. "}}"
    end

    item.key = key
    return item
end

---@param auth PostmanAuth
---@return httpgen.KeyValue
local function get_auth(auth)
    local tbl = {}

    if not auth or auth == vim.NIL then
        return tbl
    end

    for _, value in ipairs(auth[auth.type]) do
        table.insert(tbl, {
            key = value.key,
            value = value.value
        })
    end

    return tbl
end

--- get the tbl['variable'] in the current table
---@param tbl PostmanCollection | PostmanItemGroup | PostmanItem | PostmanUrl | string
---@return PostmanVariable[]
local function get_variables(tbl)
    local envs = tbl['variable'];
    if not envs or type(envs) == "string" then
        return {}
    end

    if envs ~= nil and next(envs) ~= nil then
        envs = table_utils.filter(predicate, envs)
        return table_utils.map(padronize, envs)
    end

    return envs
end

---@param request_variables PostmanVariable[]
---@param host_variables  PostmanVariable[]
---@return PostmanVariable[]
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
---@param tbl PostmanItemGroup | PostmanItem
---@return string
local function get_request_or_folder_name(tbl)
    local name = tbl.name
    if not name then
        name = "Default name"
    end
    return name
end

---check if its allowed to concatenate the header
---@param headers string|PostmanHeader[]
---@param auth PostmanAuth
---@param global_auth httpgen.KeyValue
---@param variables PostmanVariable[]
---@return string
local function get_http_headers(headers, auth, global_auth, variables)
    if type(headers) == "string" then
        error("Header is not in the correct format", 1)
    end

    local auth_to_add = get_auth(auth)
    for _, value in ipairs(auth_to_add) do
        table.insert(headers, value)
    end

    for _, value in ipairs(global_auth) do
        table.insert(headers, value)
    end

    if table_utils.is_empty(table_utils.filter(function(h) return tostring(h.key):lower() == "accept" end, headers)) then
        table.insert(headers, { key = "Accept", value = "*/*" })
    end

    if table_utils.is_empty(table_utils.filter(function(h) return tostring(h.key):lower() == "content-type" end, headers)) then
        table.insert(headers, { key = "Content-Type", value = "application/json" })
    end

    for _, header in ipairs(headers) do
        if header and header.value then
            header.value = parser.repl_variables(header.value, variables)
        end
    end


    return table_utils.join(
        headers,
        "\n",
        function(item) return item.key .. " " .. item.value end,
        function(item) return not item.disabled and item.key and item.value end
    )
end

---check if its allowed to concatenate the header
---@param request PostmanRequestBody
---@return  table | nil
local function get_http_body(request)
    if request == nil or table_utils.is_empty(request) then
        return nil
    end

    local raw_value = request.raw
    if raw_value then
        return vim.json.decode(raw_value)
    end

    return nil
end

---generate url string without variables replaced
---@param url PostmanUrl|string
---@return string
local function generate_url_encoded(url)
    if type(url) == "string" then
        return url
    end

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
---@param request PostmanRequest
---@param global_auth httpgen.KeyValue
---@param variables PostmanVariable
---@return string
local function create_http_template_for(request_name, request, global_auth, variables)
    local url = generate_url_encoded(request.url)
    local headers = get_http_headers(request.header, request.auth, global_auth, variables)
    local body = json_formatter:pretty_print(get_http_body(request.body))

    local data_to_parse = {
        name = request_name,
        method = request.method,
        url = url,
        headers = headers,
        body = body
    }

    return parser.parse_template(data_to_parse, variables)
end

---iterate through the itens recursively and returns all itens to be parsed into file
---@generic T json as object
---@param tbl PostmanCollection | PostmanItem | PostmanItemGroup
---@param global_auth httpgen.KeyValue
---@param acc_tbl Template
---@param host_variables PostmanVariable[]
---@return table<string>
local function iterate_through_itens(tbl, global_auth, acc_tbl, host_variables)
    local found_variables = get_variables(tbl)
    if found_variables then
        for _, value in ipairs(found_variables) do
            table.insert(host_variables, value)
        end
    end

    local item = tbl["item"];
    if item ~= nil then
        for idx, _ in ipairs(item) do
            iterate_through_itens(item[idx], global_auth, acc_tbl, host_variables)
        end
    end

    local req = tbl["request"] ---@cast req PostmanRequest
    if req ~= nil and req.url and req.method then
        local request_variables = get_variables(req.url)
        local variables = get_unified_variables(request_variables, host_variables)
        ---@cast tbl PostmanItem | PostmanItemGroup
        local req_name = get_request_or_folder_name(tbl)

        local result = create_http_template_for(req_name, req, global_auth, variables)
        table.insert(acc_tbl, result)
    end

    return acc_tbl
end

---@param obj table env json as table
---@return table<httpgen.KeyValue>
function postman:get_env(obj)
    local result = {}
    for _, env in ipairs(obj.values) do
        if predicate(env) then
            table.insert(result, padronize(env))
        end
    end
    return result
end

---iterate through the itens recursively and append to file
---@param envs table<httpgen.KeyValue>  
---@param obj PostmanCollection collection json as table
---@return table<string>
function postman:execute(envs, obj)
    local global_auth = get_auth(obj.auth)
    local template = iterate_through_itens(obj, global_auth, {}, envs)
    return template
end

return postman
