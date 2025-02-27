cloud_util = {}

---@param item_name string
function cloud_util:create_item(item_name)
    storage.cloud_items[item_name] = {
        name = item_name,
        count = 0,
        quality = "normal"
    }
end

---@param item_name string
---@param count number
function cloud_util:add(item_name, count)
    if storage.cloud_items[item_name] == nil then
        self:create_item(item_name)
    end

    storage.cloud_items[item_name].count = storage.cloud_items[item_name].count + count
end

---@param item_name string
---@param count number
function cloud_util:remove(item_name, count)
    if storage.cloud_items[item_name] ~= nil then
        storage.cloud_items[item_name].count = storage.cloud_items[item_name].count - count
    end
end

return cloud_util
