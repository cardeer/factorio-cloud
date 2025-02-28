cloud_storage = {}
cloud = {}
---@param item Cloud.StorageDetail
function cloud_storage:create_item(item)
    storage.cloud_items[item.name] = {
        name = item.name,
        count = item.count,
        quality = item.quality and item.quality or "normal"
    }
end

---@param item Cloud.StorageDetail
function cloud_storage:add(item)
    if storage.cloud_items[item.name] == nil or storage.cloud_items[item.name].quality ~= item.quality then
        self:create_item(item)
    else
        storage.cloud_items[item.name].count = storage.cloud_items[item.name].count + item.count
    end
end

---@param item Cloud.StorageDetail
function cloud_storage:remove(item)
    if storage.cloud_items[item.name] ~= nil and storage.cloud_items[item.name].quality == item.quality then
        local total = storage.cloud_items[item.name].count - item.count
        if total > 0 then
            storage.cloud_items[item.name].count = total
        else
            storage.cloud_items[item.name] = nil
        end
    end
end

---param item Cloud.StorageDetail
---@return boolean
function cloud:upload(item)
    return false
end

---param item Cloud.StorageDetail
---@return boolean
function cloud:download(item)
    return false
end

function cloud:item_names()
    ---@type string[]
    local item_names = {}
    for name, _ in pairs(storage.cloud_items) do
        table.insert(item_names, name)
    end
    return item_names
end

return cloud
