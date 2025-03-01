players = {}

---@type Cloud.Player
local default_player_properties = {
    quality_filtered = 'normal'

}

---@param index number
---@return Cloud.Player
function players:get(index)
    if not self[index] then
        self[index] = flib_table.deep_copy(default_player_properties)
    end

    return self[index]
end

return players
