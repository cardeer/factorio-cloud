---@param event EventData.on_entity_settings_pasted
function events.on_entity_settings_pasted(event)
    if event.source.name == event.destination.name and event.destination.name == constants.items.cloud_storage_downloader.name then
        storage_downloader.get_storage_filtered(event.destination.unit_number).filter = storage_downloader
            .get_storage_filtered(event.source.unit_number).filter
    end
end
