local postman = require('f.custom.http_file.adapters.postman')

local api = {}

---@param opts httpgen.Config
local function generate_http_file(opts)
    local json_file = io.open(opts.source_path, "r")

    --Change this for buffer
    local output_file = io.open(opts.path .. opts.filename .. ".http", "w+")
    if not json_file then
        error('Erro ao abrir arquivo')
        return;
    end

    if not output_file then
        error('Erro ao gerar arquivo')
        return;
    end

    local template = {}

    if opts.source_type == 'postman' then
        template = postman.generate(json_file, output_file)
        --vim.notify("Aquivo .http gerado com sucesso", "info")
    end

    for _, value in ipairs(template) do
        if value then
            output_file:write(value)
        end
    end


    json_file:close();
    output_file:close();
end

---@param opts httpgen.Config
---@return httpgen
function api:new(opts)
    vim.api.nvim_create_user_command('HTTPGen', function() self:generate(opts) end, {})

    return {
        opts = opts,
        generate = function() generate_http_file(opts) end
    }
end

return api
