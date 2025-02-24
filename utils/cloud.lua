cloud_util = {}

---@param item_name string
function cloud_util:create_item(item_name)
    storage.cloud_items[item_name] = {
        amount = 0
    }
end

---@param item_name string
---@param amount number
function cloud_util:add(item_name, amount)
    if storage.cloud_items[item_name] == nil then
        self:create_item(item_name)
    end

    storage.cloud_items[item_name].amount = storage.cloud_items[item_name].amount + amount
end

---@param item_name string
---@param amount number
function cloud_util:remove(item_name, amount)
    if storage.cloud_items[item_name] ~= nil then
        storage.cloud_items[item_name].amount = storage.cloud_items[item_name].amount - amount
    end

end

return cloud_util
