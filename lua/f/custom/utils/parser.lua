local table_utils = require("f.custom.utils.table")

local M = {}

local function escape(str)
    return (str:gsub('%%', '%%%%')
        :gsub('^%^', '%%^')
        :gsub('%$$', '%%$')
        :gsub('%(', '%%(')
        :gsub('%)', '%%)')
        :gsub('%.', '%%.')
        :gsub('%[', '%%[')
        :gsub('%]', '%%]')
        :gsub('%*', '%%*')
        :gsub('%+', '%%+')
        :gsub('%-', '%%-')
        :gsub('%?', '%%?'))
end

--return the string version of the given template,
--each obj field should be wrapped like {{field}}
---@param template string
---@param obj [T]
---@return string
M.parse_template = function(template, obj)
    local copy_template = template
    for key, value in pairs(obj) do
        local pattern = "%{%{" .. key .. "%}%}"
        copy_template = copy_template:gsub(pattern, escape(value))
    end
    return copy_template
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
--]
--]
--]
--]
