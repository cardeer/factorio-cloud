storage_uploader = {}

function storage_uploader.get_all()
    if not storage.uploader_list then
        ---@type {[int]: LuaInventory}
        storage.uploader_list = utils.get_all_storage_by_name(constants.items.cloud_storage_uploader.name)
    end
    return storage.uploader_list
end

---@param limit number
function storage_uploader.get_next(limit)
    storage_uploader.get_all()

    local target_list = {}
    local count = 0
    for id, inventory in pairs(storage.downloader_list) do
        if not storage.uploader_state_target then
            storage.uploader_state_target = id
        end

        if count > 0 and count <= limit then
            table.insert(target_list, id, inventory)
            count = count + 1
        end

        if storage.uploader_state_target == id then
            table.insert(target_list, id, inventory)
            count = 1
        end

        if count > limit then
            storage.uploader_state_target = id
            break
        end
    end

    if count <= limit then
        storage.uploader_state_target = nil
    end

    return target_list
end

---@param id int
---@param inventory LuaInventory
function storage_uploader.create(id, inventory)
    storage_uploader.get_all()
    storage.uploader_list[id] = inventory
end

---@param id int
function storage_uploader.remove(id)
    storage_uploader.get_all()
    storage.uploader_list = utils.filter(storage.uploader_list, function(val)
        return val[1] ~= id
    end)
end
