---@param event EventData.on_gui_click
function events.on_gui_click(event)
    local element_name = event.element.name
    local player = game.players[event.player_index]

    if gui.handlers[event.name] then
        local handler = gui.get_handler(player, event.name, element_name)

        if handler ~= nil then
            handler()
            storage.stacks_multiplier = 5
            gui.cloud_storage.reopen(player)
        end
    end
end
