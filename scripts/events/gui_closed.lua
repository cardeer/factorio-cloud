---@param event EventData.on_gui_closed
function events.on_gui_closed(event)
    local player = game.players[event.player_index]
    local entity = event.entity
    if entity and entity.name == constants.items.cloud_storage_downloader.name then
        gui.container_filter_gui.destroy(player)
    end
end
