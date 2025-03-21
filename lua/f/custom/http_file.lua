local table_utils = require("utils.table")
local parser = require("utils.parser")
local json_formatter = require("utils.json_formatter")

---map an item to http header
---@param item table
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

---iterate through the itens recursively and append to file
---@param tbl table
---@param file file*
---@return nil
local function iterate_through_item(tbl, file)
    for key, value in pairs(tbl) do
        if key == "item" then
            for idx, _ in ipairs(value) do
                iterate_through_item(value[idx], file)
            end
        end

        if key == "request" then
            if value.url and value.method then
                local body = ""
                if value.body then
                    body = vim.json.decode(value.body.raw)
                end

                local name = "Request " .. tostring(tbl)
                if tbl.name then
                    name = tbl.name
                end

                local data_to_parse = {
                    name = name,                                                                               --optional
                    method = value.method,                                                                     --required
                    url = value.url.raw,                                                                       --required
                    headers = table_utils.concat_to_string(value.header, map_to_string, can_use_header, "\n"), --optional
                    body = json_formatter:pretty_print(body)                                                   --optional
                }

                local template = "# {{name}}\n{{method}} {{url}}\n {{headers}}\n\n{{body}}\n\n\n"
                --should not write the file here
                file:write(parser.parse_template(template, data_to_parse))
            end
        end

        if key == "variable" then
        end
    end
end

---iterate through the itens recursively and append to file
---@param path string
---@param filename string
---@return nil
function To_http(path, filename)
    local file = io.open(path .. filename .. ".json", "r")
    local working_file = io.open(path .. filename .. ".http", "r+")

    if working_file and file then
        local file_as_json = vim.json.decode(file:read("*a"))
        iterate_through_item(file_as_json, working_file)
        working_file:close();
        file:close();

        vim.notify("Aquivo .http gerado com sucesso em " .. path, "info")
    else
        vim.notify("Erro ao gerar arquivo .http em " .. path, "error")
    end
end
