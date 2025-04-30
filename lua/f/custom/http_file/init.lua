local api = require('f.custom.http_file.api')

local M = {}

---@param callback function
local function open_picker(callback)
    Snacks.picker.files({
        ft = 'json',
        confirm = function(picker, item, _)
            local cwd = vim.fn.getcwd()
            local file_path = item.file:gsub("^%.", "", 1)
            local absolute_path = cwd .. file_path;
            picker:close()

            callback(absolute_path)
        end,
    })
end

---@param opts httpgen.Config
---@return httpgen
M.setup = function(opts)
    local httpgen = api:new()

    if opts.env_path then
        httpgen.setup_envs(opts)
    end

    if opts.source_path then
        httpgen.setup_envs(opts)
    end

    vim.api.nvim_create_user_command('HTTPEnv', function(_)
        open_picker(function(path)
            opts.env_path = path
            httpgen.setup_envs(opts)
        end)
    end, {})

    vim.api.nvim_create_user_command('HTTPGen', function(_)
        open_picker(function(path)
            opts.source_path = path
            httpgen.generate(opts)
        end)
    end, {})
end

return M
