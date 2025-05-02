local adapters = {
    postman = require('f.custom.http_file.adapters.postman'),
}

local api = {}
local envs = {}

---@param buffers table<integer>
local function clean_up_buf(buffers)
    for _, buf in ipairs(buffers) do
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

---@param buf integer
---@param path string
---@param bkp_buf integer
local function save_buff(buf, path, bkp_buf)
    vim.api.nvim_set_current_buf(buf)
    vim.cmd('silent write!' .. path)
    vim.api.nvim_set_current_buf(bkp_buf)
end

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

    if not adapter['get_env'] then
        error(opts.source_type .. " does not implements execute")
    end

    envs = adapter:get_env(vim.json.decode(json))
end

---@param opts httpgen.Config
local function generate_http_file(opts)
    local json = read_json(opts.source_path)
    local adapter = adapters[opts.source_type]

    if not adapter['execute'] then
        error(opts.source_type .. " does not implements execute")
    end

    if opts.output_dir then
        vim.cmd("!mkdir -p " .. opts.output_dir)
    end

    local template = adapter:execute(envs, vim.json.decode(json))

    local bkp_buf = vim.api.nvim_get_current_buf()
    local buffers = {}

    if opts.mode == 'single_buffer' then
        local buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_buf_set_name(buf, 'collection.http')

        for _, value in ipairs(template) do
            write_into_buffer(buf, value.template)
        end

        if opts.output_dir then
            save_buff(buf, opts.output_dir .. 'collection.http', bkp_buf)
        end
    end

    if opts.mode == 'multi_buffer' then
        for _, value in ipairs(template) do
            local buf = vim.api.nvim_create_buf(false, false)

            vim.api.nvim_buf_set_name(buf, value.request_name .. '.http')
            write_into_buffer(buf, value.template)

            if opts.output_dir then
                table.insert(buffers, buf)
                save_buff(buf, opts.output_dir .. value.request_name .. '.http', bkp_buf)
            end
        end
    end

    vim.defer_fn(function()
        clean_up_buf(buffers)
    end, 1000)
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
