cloud_storage = {}

cloud = {}

function get_key(item)
    return item.name .. "-" .. item.quality
end

---@param item Cloud.StorageDetail
---@return boolean
function cloud_storage:is_full(item)
    local limit = (prototypes.item[item.name] or 1) * storage.stacks_multiplier
    if storage.cloud_items[get_key(item)].count < limit then
        return false
    else
        return true
    end
end

---@param item Cloud.StorageDetail
function cloud_storage:add(item)
    if self:is_full(item) then
        return
    end
    if storage.cloud_items[get_key(item)] == nil or storage.cloud_items[get_key(item)].quality ~= item.quality then
        storage.cloud_items[get_key(item)] = item
    else
        storage.cloud_items[get_key(item)].count = storage.cloud_items[get_key(item)].count + item.count
    end
end

---@param item Cloud.StorageDetail
function cloud_storage:remove(item)
    if storage.cloud_items[get_key(item)] ~= nil and storage.cloud_items[get_key(item)].quality == item.quality then
        local total = storage.cloud_items[get_key(item)].count - item.count
        if total > 0 then
            storage.cloud_items[get_key(item)].count = total
        else
            storage.cloud_items[get_key(item)] = nil
        end
    end
end

---param item Cloud.StorageDetail
---@return boolean
function cloud:upload(item)
    cloud_storage:add(item)
    return false
end

---param item Cloud.StorageDetail
---@return boolean
function cloud:download(item)
    cloud_storage:remove(item)
    return false
end

---param item Cloud.StorageDetail
---@return boolean
function is_full(item)
    return cloud_storage:is_full(item)
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
