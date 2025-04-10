---@param event EventData.on_player_mined_entity
function events.on_player_mined_entity(event)
    local entity = event.entity
    if entity.name == constants.items.cloud_storage_downloader.name then
        storage_downloader.remove(entity.unit_number)
    end
    if entity.name == constants.items.cloud_storage_uploader.name then
        storage_uploader.remove(entity.unit_number)
    end
end
