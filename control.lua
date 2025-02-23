require('types.cloud_storage')

require('constants.general')
require('constants.items')

require('scripts.initialize')

require('scripts.events.player_joined')

frame = nil

function on_built_entity(event)
    print(event.entity.name)
end

---@param event EventData.on_gui_opened
function on_gui_opened(event)
    local player = game.players[event.player_index]

    frame = player.gui.relative.add {
        type = 'frame',
        name = 'controller',
        direction = 'vertical',
        anchor = {
            gui = defines.relative_gui_type.electric_energy_interface_gui,
            position = defines.relative_gui_position.bottom
        }
    }

    frame.style.width = 500
    frame.style.height = 200
    frame.style.padding = 5

    frame.add {
        type = 'label',
        name = 'id',
        caption = 'Network ID',
        position = defines.relative_gui_position.top
    }

    frame.add {
        type = 'button',
        caption = 'Confirm'
    }
end

function on_gui_closed(event)
    if frame ~= nil then
        frame.destroy()
    end
end

function on_gui_click(event)

end

script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_gui_click, on_gui_click)
