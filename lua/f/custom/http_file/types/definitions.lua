---@class httpgen.Config
---@field env_path string TODO
---@field source_path string
---@field source_type 'postman' | 'swagger.json' TODO
---@field mode 'single_file' | 'preserve_structure' TODO

---@class httpgen
---@field opts httpgen.Config
---@field generate function
