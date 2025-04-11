require('f.custom.dap_automator')
require('f.custom.http_file').setup({
    source_path = vim.fn.getcwd() .. "/lua/f/custom/test-api.json",
    source_type = 'postman',
}
)
