---@type Cloud.Storage
local cloud_storage = {}

if not storage.cloud_items then
    storage.cloud_items = {}
end

local function get_key(item)
    return item.name .. "-" .. (item.quality or "normal")
end

---@param item_name string
---@return int
local function get_prototype_stack(item_name)
    return prototypes.item[item_name] and prototypes.item[item_name].stack_size or 1
end

---@return int
local function count_researched_technology()
    for i = 1, 100 do
        local tech = game.forces.player.technologies[constants.items.technology.prefix .. i]
        if not tech or not tech.researched then
            return (i - 1)
        end
    end
    return 0
end

---@param item Cloud.StorageDetail
---@return boolean
function cloud_storage:is_full(item)
    if not storage.cloud_items[get_key(item)] then
        return false
    end
    local limit = get_prototype_stack(item.name) * settings.startup["cloud_storage_stack_multiplier"].value *
        count_researched_technology()

    if storage.cloud_items[get_key(item)].count < limit then
        return false
    else
        return true
    end
end

---@param item Cloud.StorageDetail
function cloud_storage:add(item)
    if storage.cloud_items[get_key(item)] == nil then
        storage.cloud_items[get_key(item)] = item
    else
        storage.cloud_items[get_key(item)].count = storage.cloud_items[get_key(item)].count + item.count
    end
    script.raise_event(events.on_cloud_updated_event, {
        item = item
    })
end

---@param item Cloud.StorageDetail
function cloud_storage:remove(item)
    if storage.cloud_items[get_key(item)] ~= nil and storage.cloud_items[get_key(item)].quality == item.quality then
        local total = storage.cloud_items[get_key(item)].count - item.count
        storage.cloud_items[get_key(item)].count = total
        script.raise_event(events.on_cloud_updated_event, {
            item = item
        })
    end
end

---@param item Cloud.StorageDetail
---@return number
function cloud_storage:get_count(item)
    if not storage.cloud_items[get_key(item)] then
        return 0
    end
    return storage.cloud_items[get_key(item)].count
end

cloud = {}

---@param item Cloud.StorageDetail
---@return boolean
function cloud:upload(item)
    if cloud_storage:is_full(item) then
        return false
    end

    cloud_storage:add(item)
    return true
end

---@param item Cloud.StorageDetail
---@return ItemStackDefinition
function cloud:download(item)
    cloud_storage:remove(item)
    ---@type ItemStackDefinition
    return item
end

---@param item Cloud.StorageDetail
---@return boolean
function cloud:can_download(item)
    return cloud_storage:get_count(item) >= item.count and true or false
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
    local item_stack = prototype_stack < item.count and prototype_stack or item.count

    local maximum_insert_to_inventory = inventory.get_insertable_count({
        name = item.name,
        quality = item.quality
    })

    local insert_stack = maximum_insert_to_inventory > item_stack and item_stack or maximum_insert_to_inventory
    if insert_stack == 0 then
        return
    end

    ---@type Cloud.StorageDetail
    local item_inserted = {
        name = item.name,
        quality = item.quality,
        count = insert_stack
    }

    inventory.insert({
        name = item.name,
        quality = item.quality,
        count = insert_stack
    })

    cloud_storage:remove(item_inserted)
end

---@param item Cloud.StorageDetail | ItemStackDefinition
function cloud:item_count(item)
    return cloud_storage:get_count(item)
end

function cloud:item_names()
    local item_names = {}
    for _, item in pairs(storage) do
        table.insert(item_names, item.name)
    end
    return item_names
end

---@param quality string
---@return Cloud.StorageDetail[]
function cloud:get_items(quality)
    ---@type Cloud.StorageDetail[]
    local items = {}
    local cloud_items = storage.cloud_items or {}
    for key, item in pairs(cloud_items) do
        if get_key({
                name = item.name,
                quality = quality
            }) == key then
            table.insert(items, item)
        end
    end
    return items
end

---@return boolean
function cloud:is_available()
    return count_researched_technology() > 0
end

return cloud
