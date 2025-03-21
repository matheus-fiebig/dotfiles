local M = {}

--return the string version of the given template,
--each obj field should be wrapped like {{field}}
---@param template string
---@param obj [t]
---@return string
M.parse_template = function(template, obj)
    local copy_template = template
    for key, value in pairs(obj) do
        local pattern = "%{%{" .. key .. "%}%}"
        copy_template = copy_template:gsub(pattern, value)
    end
    return copy_template
end

return M
