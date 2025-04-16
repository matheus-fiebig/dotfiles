local postman = require('f.custom.http_file.adapters.postman')

local api = {}

---get the adapter used to create the .http template
---@param type httpgen.Config.Type
---@return httpgen.Adapter
local function get_adapter(_)
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

    if opts.mode == 'single_buffer' then
        local buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_set_name(buf, 'collection.http')
        for _, value in ipairs(template) do
            local line_count = vim.api.nvim_buf_line_count(0)
            vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, vim.split(value, "\n"))
        end
    end

    if opts.mode == 'multi_buffer' then
        for _, value in ipairs(template) do
            local buf = vim.api.nvim_create_buf(true, false)
            --vim.api.nvim_buf_set_name(buf, value.name .. '.http')

            local line_count = vim.api.nvim_buf_line_count(0)
            vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, vim.split(value, "\n"))
        end
    end


    json_file:close();
end

---@param opts httpgen.Config
---@return httpgen
function api:new(opts)
    local obj = {
        generate = function(_opts) generate_http_file(_opts) end
    }

    vim.api.nvim_create_user_command('HTTPGen', function(_)
        Snacks.picker.files({
            confirm = function(picker, item, _)
                local cwd = vim.fn.getcwd()
                local file_path = item.file:gsub("^%.", "", 1)
                local absolute_path = cwd .. file_path;
                picker:close()

                obj.generate({
                    source_path = absolute_path,
                    source_type = opts.source_type,
                    mode = opts.mode,
                    env_path = opts.env_path
                })
            end,
        })
    end, {})

    return obj
end

return api
