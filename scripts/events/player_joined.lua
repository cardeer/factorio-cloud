---@param event EventData.on_player_joined_game
function on_player_joined(event)
    if storage.players[event.player_index] == nil then
        storage.players[event.player_index] = {}
    end
end

script.on_event(defines.events.on_player_created, on_player_joined)
