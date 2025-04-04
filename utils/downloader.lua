storage_downloader = {}

---@type Downloader.Filtered
local filter = {
    filter = nil,
    quality = 'normal',
}

---@param id number
---@return Downloader.Filtered
function storage_downloader.get(id)
    if not storage_downloader[id] then
        storage_downloader[id] = flib_table.deep_copy(filter)
    end

    return storage_downloader[id]
end
