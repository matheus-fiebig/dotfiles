require('f.custom.dap_automator')
require('f.custom.utils.socket')
require('f.custom.http_file').setup({
    source_type = 'postman',
    mode = 'multi_buffer',
    output_dir = 'http/'
})
