player_util = {}

---@param player_index number
function player_util.getGui(player_index)
    if storage.players[player_index] == nil then
        return nil
    end

    return storage.players[player_index].gui
end

return player_util
