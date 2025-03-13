---@param event EventData.on_gui_opened
function events.on_gui_opened(event)
    local player = game.players[event.player_index]

    if (player.opened_self == true and event.gui_type == defines.gui_type.controller) then
        gui.cloud_storage_gui.create(player)
    end

    local entity = event.entity
    if entity and entity.name == constants.items.cloud_storage_downloader.name then
        gui.container_filter_gui.create(player, entity)
    end
end
