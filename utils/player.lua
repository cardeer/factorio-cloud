player_util = {}

---@param player_index uint
function player_util.getGui(player_index)
    if storage.players[player_index] == nil then
        return nil
    end
end

return player_util
