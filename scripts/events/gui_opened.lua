---@param event EventData.on_gui_opened
function events.on_gui_opened(event)
    local player = game.players[event.player_index]

    if (player.opened_self == true and event.gui_type == defines.gui_type.controller) then
        fetch_content_storage_cloud()
        gui.cloud_storage.create(player)
    end
end
