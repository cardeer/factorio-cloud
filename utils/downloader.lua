---@type Downloader.Filtered
local filter = {
    filter = nil,
    quality = 'normal',
}

if not storage_downloader then
    storage_downloader = {}
end

if not storage.downloader_selected then
    storage.downloader_selected = {}
end

---@param id number
---@return Downloader.Filtered
function storage_downloader.get(id)
    if not storage.downloader_selected[id] then
        storage.downloader_selected[id] = flib_table.deep_copy(filter)
    end

    return storage.downloader_selected[id]
end
