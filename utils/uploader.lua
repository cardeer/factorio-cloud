storage_uploader = {}

function storage_uploader.get_all()
    if not storage.uploader_list then
        ---@type {[int]: LuaInventory}
        storage.uploader_list = utils.get_all_storage_by_name(constants.items.cloud_storage_uploader.name)
    end
    return storage.uploader_list
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
