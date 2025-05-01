storage_downloader = {}

---@type Downloader.Filtered
local default_filter = {
    filter = nil,
    quality = 'normal'
}

---@param id number
---@return Downloader.Filtered
function storage_downloader.get_storage_filtered(id)
    if not storage.downloader_selected then
        storage.downloader_selected = {}
    end

    if not storage.downloader_selected[id] then
        storage.downloader_selected[id] = flib_table.deep_copy(default_filter)
    end

    return storage.downloader_selected[id]
end

function storage_downloader.get_all()
    if not storage.downloader_list then
        ---@type {[int]: LuaInventory}
        storage.downloader_list = utils.get_all_storage_by_name(constants.items.cloud_storage_downloader.name)
    end
    return storage.downloader_list
end

---@param limit number
function storage_downloader.get_next(limit)
    storage_downloader.get_all()

    local target_list = {}
    local count = 0
    for id, inventory in pairs(storage.downloader_list) do
        if not storage.downloader_state_target then
            storage.downloader_state_target = id
        end

        if count > 0 and count <= limit then
            table.insert(target_list, id, inventory)
            count = count + 1
        end

        if storage.downloader_state_target == id then
            table.insert(target_list, id, inventory)
            count = 1
        end

        if count > limit then
            storage.downloader_state_target = id
            break
        end
    end

    if count <= limit then
        storage.downloader_state_target = nil
    end

    return target_list
end

---@param id int
---@param inventory LuaInventory
function storage_downloader.create(id, inventory)
    storage_downloader.get_all()
    storage.downloader_list[id] = inventory
end

---@param id int
function storage_downloader.remove(id)
    storage_downloader.get_all()
    storage.downloader_list = utils.filter(storage.downloader_list, function(val)
        return val[1] ~= id
    end)
end
