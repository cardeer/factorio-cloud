---@param event EventData.on_gui_click
function events.on_gui_click(event)
    if gui.handlers[event.name] then
        local element_name = event.element.name
        local player = game.players[event.player_index]
        local handler = gui.get_handler(player, event.name, element_name)

        if handler ~= nil then
            handler()
            gui.cloud_storage.reopen(player)
        end
    end
end
