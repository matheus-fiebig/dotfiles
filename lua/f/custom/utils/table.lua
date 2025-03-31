local M = {}

M.unpack = table.unpack or unpack

--- Appends all elements from the second array to the first one.
---@param a1 table the first array
---@param a2 table the second array
---@return table #the updated first array
M.concat_arrays = function(a1, a2)
    if #a2 == 0 then
        return a1
    end
    for i = 1, #a2 do
        a1[#a1 + 1] = a2[i]
    end
    return a1
end

M.contains = vim.tbl_contains

M.filter = vim.tbl_filter

M.count = vim.tbl_count

M.is_empty = vim.tbl_isempty

M.map = vim.tbl_map

--- Concatenate the specified table into a single string
---@generic T
---@param tbl T[] | nil # The table to concatenate
---@param separator string # The value separator
---@param mapper? fun(item: T): string # The optional mapper function
---@param predicate? fun(item: T): boolean # The optional predicate function
---@return string # The concatenated string
M.join = function(tbl, separator, mapper, predicate)
    if not tbl or #tbl == 0 then
        return ""
    end

    local result = {}

    for _, v in ipairs(tbl) do
        if not predicate or predicate(v) then
            if mapper then
                table.insert(result, mapper(v))
            else
                table.insert(result, v)
            end
        end
    end

    return table.concat(result, separator)
end

M.make_default_table = function(tbl, key)
    if key == nil then
        error("table.make_default_table: key is nil for table " .. vim.inspect(tbl))
    end
    return setmetatable(tbl, {
        __index = function(_, actual_key)
            if key == actual_key then
                tbl[key] = {}
            end
            return tbl[key]
        end,
    })[key]
end

-- Removes all gaps in the array (https://stackoverflow.com/a/53038524/10365305)
M.compact = function(arr, gaps)
    local j = 1
    local n = #arr

    for i = 1, n do
        if gaps[i] then
            arr[i] = nil
        else
            -- Move i's kept value to j's position, if it's not already there.
            if i ~= j then
                arr[j] = arr[i]
                arr[i] = nil
            end
            j = j + 1 -- Increment position of where we'll place the next kept value.
        end
    end
    return arr
end

-- Returns an iterator that yields all items in the table in the order specified by compare.
M.pairs_by_keys = function(tbl, compare)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    compare = compare or function(a, b)
        return a:lower() < b:lower()
    end
    table.sort(keys, compare)
    local i = 0
    -- Return an iterator function
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], tbl[keys[i]]
        end
    end
end

return M
