local cloud_storage = {}
cloud = {}

local function get_key(item)
    return item.name .. "-" .. item.quality
end

local function get_prototype_stack(item_name)
    return prototypes.item[item_name] and prototypes.item[item_name].stack_size or 1
end

---@param item Cloud.StorageDetail
---@return boolean
function cloud_storage:is_full(item)
    local stack_size = (prototypes.item[item.name] and prototypes.item[item.name].stack_size or 1)
    local limit = stack_size * storage.stacks_multiplier
    if not storage.cloud_items[get_key(item)] or storage.cloud_items[get_key(item)].count < limit then
        return false
    else
        return true
    end
end

---@param item Cloud.StorageDetail
function cloud_storage:add(item)
    if cloud_storage:is_full(item) then
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

---@param item Cloud.StorageDetail
---@return boolean
function cloud:upload(item)
    cloud_storage:add(item)
    return false
end

---@param item Cloud.StorageDetail
---@return boolean
function cloud:download(item)
    cloud_storage:remove(item)
    return false
end

---@param item Cloud.StorageDetail
---@return boolean
function cloud:is_full(item)
    return cloud_storage:is_full(item)
end

---@param inventory LuaInventory
---@param item Cloud.StorageDetail
function cloud:move_to_inventory(inventory, item)
    local prototype_stack = get_prototype_stack(item.name)
    local item_stack = prototype_stack < item.count and prototype_stack or prototype_stack
    local maximum_insert_to_inventory = inventory.get_insertable_count({
        name = item.name,
        quality = item.quality
    })
    local minimum_insert_stack = maximum_insert_to_inventory > item_stack and item_stack or maximum_insert_to_inventory
    ---@type Cloud.StorageDetail
    local item_inserted = { name = item.name, quality = item.quality, count = minimum_insert_stack }
    inventory.insert({ name = item.name, quality = item.quality, count = minimum_insert_stack })
    cloud_storage:remove(item_inserted)
    return item_inserted
end

function cloud:item_names()
    local item_names = {}
    for _, item in pairs(storage.cloud_items) do
        table.insert(item_names, item.name)
    end
    return item_names
end

---@param quality string
---@return Cloud.StorageDetail[]
function cloud:get_items(quality)
    ---@type Cloud.StorageDetail[]
    local items = {}
    for key, item in pairs(storage.cloud_items) do
        if get_key({ name = item.name, quality = quality }) == key then
            table.insert(items, item)
        end
    end
    return items
end

return cloud
