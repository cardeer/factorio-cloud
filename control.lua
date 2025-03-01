require('utils.player')
require('types')

require('constants.main')

require('utils.cloud')
require('utils.player')
require("utils.utils")

require('scripts.initialize')
require('scripts.events')

require('gui.main')

flib_table = require('__flib__.table')
mod_gui = require("mod-gui")

---@type LuaGuiElement
frame = nil

function on_built_entity(event)
    print(event.entity.name)
end

script.on_event(defines.events.on_built_entity, on_built_entity)

script.on_event(defines.events.on_gui_opened, events.on_gui_opened)
script.on_event(defines.events.on_gui_closed, events.on_gui_closed)
script.on_event(defines.events.on_gui_click, events.on_gui_click)

script.on_event(defines.events.on_script_inventory_resized, function(event)
    print("on_script_inventory_resized" .. event.name)
end)

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    player = game.players[event.player_index]
    if player.opened and player.opened.type == 'container' then
        items = player.opened.get_inventory(defines.inventory.chest).get_contents()
        fetch_content_storage_cloud()
        -- cloud_storage:set_items(items)
    end
    -- player.opened_gui_type
    print("on_player_main_inventory_changed" .. player.opened_gui_type)
end)

function fetch_content_storage_cloud()
    ---@type Cloud.StorageDetail[]
    items = {}
    for _, surface in pairs(game.surfaces) do
        for _, container in pairs(surface.find_entities_filtered({
            name = "cloud-storage"
        })) do
            for _, item in pairs(container.get_inventory(defines.inventory.chest).get_contents()) do
                table.insert(items, item)
            end
        end
    end
    -- cloud_storage:set_items(items)
end

-- script.on_event(defines.events.on_built_entity, function(event)
--     if event.entity.name == "cloud-storage" then
--         cloud_storage:create_storage(event.entity.unit_number)
--     end
-- end)

-- script.on_event(defines.events.on_player_mined_entity, function(event)
--     if event.entity.name == "cloud-storage" then
--         cloud_storage:remove_storage(event.entity.unit_number)
--     end
-- end)

-- script.on_event(defines.events.on_entity_died, function(event)
--     if event.entity.name == item_constants.cloud_storage_uploader.name then
--         cloud_storage:remove_storage(event.entity.unit_number)
--     end
-- end)
