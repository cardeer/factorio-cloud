---@param event EventData.on_gui_elem_changed
function events.on_gui_elem_changed(event)
    local player = game.get_player(event.player_index)
    local element = event.element

    if player and element.name:find("filter_slot-") then
        local frame = gui.container_filter_gui
        if not frame then return end

        local entity = frame.get_entity_target(player)
        storage.container.filter[entity.unit_number] = element.elem_value
        if not storage.container.quality[entity.unit_number] then
            storage.container.quality[entity.unit_number] = "normal"
        end
    end
end
