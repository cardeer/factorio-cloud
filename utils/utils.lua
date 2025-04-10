utils = {}

--- @generic K, V
--- @param tbl table<K,V>
--- @param filter fun(value: table<K,V>): boolean
function utils.filter(tbl, filter)
    local tb = {}
    for key, val in pairs(tbl) do
        if filter({ key, val }) then
            table.insert(tb, key, val)
        end
    end
    return tb
end

---@param name string
function utils.get_all_storage_by_name(name)
    local tb = {}
    for _, surface in pairs(game.surfaces) do
        local surface_items = surface.find_entities_filtered({
            name = name
        })

        for _, container in pairs(surface_items) do
            local inventory = container.get_inventory(defines.inventory.chest)
            if inventory then
                table.insert(tb, container.unit_number, inventory)
            end
        end
    end

    return tb
end
