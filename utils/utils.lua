function split(input_str, sep)
    -- if sep is null, set it as space
    if sep == nil then
        sep = '%s'
    end
    -- define an array
    local t = {}
    -- split string based on sep
    for str in string.gmatch(input_str, '([^' .. sep .. ']+)')
    do
        -- insert the substring in table
        table.insert(t, str)
    end
    -- return the array
    return t
end
