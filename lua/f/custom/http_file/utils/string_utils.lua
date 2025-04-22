local M = {}

--return the escaped string
---@param str string
---@return string
M.escape = function(str)
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

--check valid json
---@param str string
---@return boolean
M.is_json = function(str)
    local ok, result = pcall(vim.json.decode, str)
    return ok
end

return M
