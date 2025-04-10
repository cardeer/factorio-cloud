---@param event EventData.on_gui_elem_changed
function events.on_gui_elem_changed(event)
    local player = game.get_player(event.player_index)
    local element = event.element

    if player and element.name:find("cloud_download_filter-") then
        local frame = gui.container_filter_gui
        if not frame then return end

        local entity = frame.get_entity_target(player)
        storage_downloader.get_storage_filtered(entity.unit_number).filter = element.elem_value
    end
end
