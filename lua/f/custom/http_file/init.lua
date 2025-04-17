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
        httpgen.setup_envs({
            source_type = opts.source_type,
            mode = opts.mode,
            env_path = opts.env_path
        })
    end

    if opts.source_path then
        httpgen.setup_envs({
            source_type = opts.source_type,
            mode = opts.mode,
            source_path = opts.env_path
        })
    end

    vim.api.nvim_create_user_command('HTTPEnv', function(_)
        open_picker(function(path)
            httpgen.setup_envs({
                source_type = opts.source_type,
                mode = opts.mode,
                env_path = path
            })
        end)
    end, {})

    vim.api.nvim_create_user_command('HTTPGen', function(_)
        open_picker(function(path)
            httpgen.generate({
                source_path = path,
                source_type = opts.source_type,
                mode = opts.mode,
            })
        end)
    end, {})
end

return M
