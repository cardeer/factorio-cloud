---@param event EventData.on_built_entity
function events.on_built_entity(event)
    local entity = event.entity
    if entity.name == constants.items.cloud_storage_downloader.name then
        storage_downloader.create(entity.unit_number, entity.get_inventory(defines.inventory.chest))
    elseif entity.name == constants.items.cloud_storage_uploader.name then
        storage_uploader.create(entity.unit_number, entity.get_inventory(defines.inventory.chest))
    end
end
