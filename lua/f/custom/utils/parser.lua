local table_utils = require("f.custom.utils.table")

local M = {}

--return the string version of the given template,
--each obj field should be wrapped like {{field}}
---@param template string
---@param obj [T]
---@return string
M.parse_template = function(template, obj)
    local copy_template = template
    for key, value in pairs(obj) do
        local pattern = "%{%{" .. key .. "%}%}"
        copy_template = copy_template:gsub(pattern, value)
    end
    return copy_template
end

---parse vars from a specific table
---@param tbl table | nil
---@param variables table<{key: string, value: string}> | nil
---@return table | string
M.parse_variables = function(tbl, variables)
    if not tbl then
        return {}
    end

    if not variables then
        return tbl
    end

    local result = {}

    for _, value in pairs(table) do
        if #value > 0 then
            for idx, inner_tbl in ipairs(value) do
                table.insert(result, M.parse_variables(inner_tbl[idx], variables))
            end
        end

        for key_v, value_v in pairs(variables) do
            if string.find(string(key_v), value, 1, true) then
                table.insert(result, string(string.gsub(string(key_v), value, value_v)))
            end
        end
    end



    return result
end


return M


--"path": [
--"v1.0",
--"organizations",
--":organizationId",
--"bulk_action",
--":bulkActionId"
--],
--"host": [
--"{{baseUrl}}"
--],
--"query": [],
--"variable": [
--{
--"type": "any",
--"value": "<uuid>",
--"key": "organizationId",
--"disabled": false,
--"description": {
--"content": "(Required) The organization's GUID.",
--"type": "text/plain"
--}
--},
--{
--"type": "any",
--"value": "<uuid>",
--"key": "bulkActionId",
--"disabled": false,
--"description": {
--"content": "(Required) The GUID of the bulk action.",
--"type": "text/plain"
--}
--}
--]
