local table_utils = require("f.custom.utils.table")

local M = {}
local template = "###\n# {{name}}\n{{method}} {{url}}\n{{headers}}\n\n{{body}}\n\n\n"

---@param text string
---@param variables httpgen.KeyValue[]
---@return string
M.repl_variables = function(text, variables)
    local found_variable = table_utils.filter(function(item)
        local matched = text:find(item.key, 1, true)
        return not not matched and matched > 0
    end, variables)

    if found_variable and #found_variable > 0 then
        local result = text:gsub(found_variable[1].key, found_variable[1].value, 1)
        return result
    end

    return text
end

--return the string version of the http template,
--each obj field should be wrapped like {{field}}
---@generic T any
---@param obj table<T>
---@return string
M.parse_template = function(obj, variables)
    local copy_template = template
    for key, value in pairs(obj) do
        local pattern = "%{%{" .. key .. "%}%}"
        local value_with_variable = M.repl_variables(tostring(value), variables)
        copy_template = copy_template:gsub(pattern, Escape(value_with_variable))
    end
    return copy_template
end

return M
