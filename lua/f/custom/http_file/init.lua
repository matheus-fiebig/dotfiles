local api = require('f.custom.http_file.api')

local M = {}

---@param opts httpgen.Config
---@return httpgen
M.setup = function(opts)
    return api:new(opts)
end

return M
