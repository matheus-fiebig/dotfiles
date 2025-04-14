--------------------------------------
---                                ---
---             GENERIC            ---
---                                ---
--------------------------------------
---@class httpgen.KeyValue
---@field key string
---@field value string


--------------------------------------
---                                ---
---             HTTPGEN            ---
---                                ---
--------------------------------------
---@generic T Json template
---@class httpgen.Adapter
---@field execute fun(obj: table): Template

---@alias Template string[]

---@alias httpgen.Config.Mode 'single_file' | 'preserve_structure'
---@alias httpgen.Config.Type 'postman' | 'swagger.json'
---@class httpgen.Config
---@field env_path string | nil
---@field source_path string | nil
---@field source_type httpgen.Config.Type
---@field mode httpgen.Config.Mode

---@class httpgen
---@field opts httpgen.Config
---@field generate function

--------------------------------------
---                                ---
---             POSTMAN            ---
---                                ---
--------------------------------------
---@class PostmanCollection
---@field info PostmanInfo
---@field item PostmanItem[]|PostmanItemGroup[]
---@field event? PostmanEvent[]
---@field variable? PostmanVariable[]
---@field auth? PostmanAuth|nil

---@class PostmanInfo
---@field name string
---@field schema string

---@class PostmanItem
---@field id? string
---@field name? string
---@field variable? PostmanVariable[]
---@field event? PostmanEvent[]
---@field request PostmanRequest
---@field response? PostmanResponse[]

---@class PostmanItemGroup
---@field name? string
---@field variable? PostmanVariable[]
---@field item PostmanItem[]|PostmanItemGroup[]
---@field event? PostmanEvent[]
---@field auth? PostmanAuth|nil

---@class PostmanEvent
---@field id? string
---@field listen string
---@field script PostmanScript
---@field disabled? boolean

---@class PostmanScript
---@field id? string
---@field type? string
---@field exec string[]|string
---@field src? PostmanUrl
---@field name? string

---@class PostmanUrl
---@field raw? string
---@field protocol? string
---@field host string[]
---@field path string[]
---@field port? string
---@field query PostmanQueryParam[]
---@field hash? string
---@field variable? PostmanVariable[]

---@class PostmanQueryParam
---@field key? string|nil
---@field value? string|nil
---@field disabled? boolean

---@class PostmanRequest
---@field url PostmanUrl|string
---@field auth? PostmanAuth|nil
---@field proxy? PostmanProxyConfig
---@field method? "GET"|"PUT"|"POST"|"PATCH"|"DELETE"|"COPY"|"HEAD"|"OPTIONS"|"LINK"|"UNLINK"|"PURGE"|"LOCK"|"UNLOCK"|"PROPFIND"|"VIEW"|string
---@field header PostmanHeader[]|string
---@field body? PostmanRequestBody|nil

---@class PostmanRequestBody
---@field mode? "raw"|"urlencoded"|"formdata"|"file"|"graphql"
---@field raw? string
---@field graphql? table
---@field urlencoded? PostmanUrlEncodedParameter[]
---@field formdata? PostmanFormParameter[]
---@field file? PostmanFile
---@field options? table
---@field disabled? boolean

---@class PostmanUrlEncodedParameter
---@field key string
---@field value? string
---@field disabled? boolean

---@class PostmanFormParameter
---@field key string
---@field value? string
---@field src? string[]|string|nil
---@field disabled? boolean
---@field type? "text"|"file"
---@field contentType? string

---@class PostmanFile
---@field src? string|nil
---@field content? string

---@class PostmanHeader
---@field key string
---@field value string
---@field disabled? boolean

---@class PostmanResponse
---@field id? string
---@field originalRequest? PostmanRequest
---@field responseTime? string|number|nil
---@field timings? table|nil
---@field header PostmanHeader[]|string|nil
---@field body? string|nil
---@field status? string
---@field code? integer

---@class PostmanVariable
---@field id? string
---@field key? string
---@field value? any
---@field type? "string"|"boolean"|"any"|"number"
---@field name? string
---@field system? boolean
---@field disabled? boolean

---@class PostmanAuth
---@field type "apikey"|"awsv4"|"basic"|"bearer"|"digest"|"edgegrid"|"hawk"|"noauth"|"oauth1"|"oauth2"|"ntlm"
---@field noauth? any
---@field apikey? PostmanAuthAttribute[]
---@field awsv4? PostmanAuthAttribute[]
---@field basic? PostmanAuthAttribute[]
---@field bearer? PostmanAuthAttribute[]
---@field digest? PostmanAuthAttribute[]
---@field edgegrid? PostmanAuthAttribute[]
---@field hawk? PostmanAuthAttribute[]
---@field ntlm? PostmanAuthAttribute[]
---@field oauth1? PostmanAuthAttribute[]
---@field oauth2? PostmanAuthAttribute[]

---@class PostmanAuthAttribute
---@field key string
---@field value? any
---@field type? string

---@class PostmanProxyConfig
---@field match? string
---@field host? string
---@field port? integer
---@field tunnel? boolean
---@field disabled? boolean
