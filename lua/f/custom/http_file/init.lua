local postman = require('f.custom.http_file.adapters.postman')

local M = {}

M.generate_http_file = function(opts)
    opts = {
        path = vim.fn.getcwd() .. "/lua/f/custom/",
        filename = 'test-api',
        type = 'postman',
    }

    --Change this for a new buffer
    local json_file = io.open(opts.path .. opts.filename .. ".json", "r")
    local output_file = io.open(opts.path .. opts.filename .. ".http", "w+")
    if not json_file then
        error('Erro ao abrir arquivo')
        return;
    end

    if not output_file then
        error('Erro ao gerar arquivo')
        return;
    end

    if opts.type == 'postman' then
        postman.generate(json_file, output_file)
        vim.notify("Aquivo .http gerado com sucesso", "info")
    end

    json_file:close();
    output_file:close();
end

M.setup = function(opts)
    vim.api.nvim_create_user_command('GenerateHttpFile', function(args)
        M.generate_http_file(opts)
    end, {})
end

return M
