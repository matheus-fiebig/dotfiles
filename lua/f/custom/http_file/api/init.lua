local adapters = {
    postman = require('f.custom.http_file.adapters.postman')
}

local api = {}
local envs = {}

---@param buf integer
---@param data string
local function write_into_buffer(buf, data)
    local line_count = vim.api.nvim_buf_line_count(0)
    vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, vim.split(data, "\n"))
end

---@param source_path string
---@return any
local function read_json(source_path)
    local json_file = io.open(source_path, "r")
    if not json_file then
        error('Erro ao abrir arquivo')
    end

    local json = json_file:read("*a");

    json_file:close();

    return json
end

---@param opts httpgen.Config
local function setup_envs(opts)
    local json = read_json(opts.env_path)
    local adapter = adapters[opts.source_type]
    envs = adapter:get_env(vim.json.decode(json))
end

---@param opts httpgen.Config
local function generate_http_file(opts)
    local json = read_json(opts.source_path)
    local adapter = adapters[opts.source_type]
    local template = adapter:execute(envs, vim.json.decode(json))

    if opts.mode == 'single_buffer' then
        local buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_set_name(buf, 'collection.http')
        for _, value in ipairs(template) do
            write_into_buffer(buf, value)
        end
    end

    if opts.mode == 'multi_buffer' then
        for _, value in ipairs(template) do
            local buf = vim.api.nvim_create_buf(true, false)
            write_into_buffer(buf, value)
        end
    end
end

---@return httpgen
function api:new()
    local obj = {
        setup_envs = function(opts) setup_envs(opts) end,
        generate = function(opts) generate_http_file(opts) end
    }
    return obj
end

return api
