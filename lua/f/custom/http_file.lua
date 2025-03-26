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

---@param tbl table
---@param host_env table
---@param key string
---@param value table
---@return string
---THERE ARE OTHERS ENVS THAT ARE NOT COMPACTED IN HOST_ENV
---SO I NEED TO GET ALL THE ONES BEFORE THE CURRENT REQUEST PARSED INTO IT
local function create_http_template_parsed(tbl, host_env, key, value)
    --local env_vars = tbl['variables']

    local body = ""
    if next(value.body) ~= nil then
        local raw_value = value.body.raw
        if raw_value then
            body = raw_value
        else
            Snacks.notifier(vim.json.encode(value.body), "trace")
        end
    end

    local name = "Request " .. tostring(tbl)
    if tbl.name then
        name = tbl.name
    end

    local headers = value.header
    if not table_utils.filter(function(h) return h.key == "Accept" end, headers) then
        table.insert(headers, { key = "Accept", value = "*/*" })
    end

    if not table_utils.filter(function(h) return h.key == "Content-Type" end, headers) then
        table.insert(headers, { key = "Content-Type", value = "application/json" })
    end

    local data_to_parse = {
        name = name,                                                                          --optional
        method = value.method,                                                                --required
        url = value.url.raw,                                                                  --required
        headers = table_utils.concat_to_string(headers, map_to_string, can_use_header, "\n"), --optional
        body = json_formatter:pretty_print(body)                                              --optional
    }

    local template = "###\n# {{name}}\n{{method}} {{url}}\n{{headers}}\n\n{{body}}\n\n\n"
    return parser.parse_template(template, data_to_parse)
end

---iterate through the itens recursively and returns all itens to be parsed into file
---@param tbl table
---@param acc_tbl table
---@return table<string>
local function iterate_through_item(tbl, acc_tbl)
    --tbl must allways be sorted so i can get the env first and then pass it to create_http_template_parsed
    for key, value in pairs(tbl) do
        if key == "item" then
            for idx, _ in ipairs(value) do
                iterate_through_item(value[idx], acc_tbl)
            end
        end

        if key == "request" and value.url and value.method then
            local result = create_http_template_parsed(tbl, env, key, value)
            table.insert(acc_tbl, result)
        end
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
