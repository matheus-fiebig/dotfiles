local api = require('f.custom.http_file.api')

local M = {}

M.setup = function(opts)
    opts = {
        path = vim.fn.getcwd() .. "/lua/f/custom/",
        filename = 'test-api',
        type = 'postman',
    }

    return api:new(opts)
end

return M
