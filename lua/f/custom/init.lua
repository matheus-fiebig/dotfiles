require('f.custom.dap_automator')
require('f.custom.http_file').setup({
    source_type = 'postman',
    mode = 'multi_buffer',
    output_dir = 'http/'
})
