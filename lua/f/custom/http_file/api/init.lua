local postman = require('f.custom.http_file.adapters.postman')

local api = {}

---get the adapter used to create the .http template
---@param type httpgen.Config.Type
---@return httpgen.Adapter
local function get_adapter(type)
    return postman
end

---@param opts httpgen.Config
local function generate_http_file(opts)
    local json_file = io.open(opts.source_path, "r")
    if not json_file then
        error('Erro ao abrir arquivo')
        return;
    end

    local json = json_file:read("*a");
    local adapter = get_adapter(opts.source_type)
    local template = adapter:execute(vim.json.decode(json))

    local buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, template)

    json_file:close();
end

---@param opts httpgen.Config
---@return httpgen
function api:new(opts)
    local obj = {
        opts = opts,
        generate = function() generate_http_file(opts) end
    }

    vim.api.nvim_create_user_command('HTTPGen', function(args)
        obj.generate()
    end, {})

    return api
end

return api
