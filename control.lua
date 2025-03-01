require('types')

require('constants.main')

require('utils.cloud_storage')
require('utils.player')

require('scripts.initialize')

require('scripts.events.player_joined')
require("utils.utils")

mod_gui = require("mod-gui")

---@type LuaGuiElement
frame = nil

function on_built_entity(event)
    print(event.entity.name)
end

function destroy_storage_cloud_ui(player)
    if player.gui.screen.cloud_storage_gui ~= nil then
        player.gui.screen.cloud_storage_gui.destroy()
    end

    if frame ~= nil then
        frame.destroy()
    end
end

---@param player LuaPlayer
function open_storage_cloud_ui(player)
    if player.gui.relative[constants.gui.cloud_storage.name] ~= nil then
        player.gui.relative[constants.gui.cloud_storage.name].destroy()
    end

    local items_per_row = 10

    ---@type LuaGuiElement
    local frame = player.gui.relative.add({
        type = 'frame',
        name = constants.gui.cloud_storage.name,
        direction = 'vertical',
        caption = 'Cloud Storage',
        anchor = {
            gui = defines.relative_gui_type.controller_gui,
            position = defines.relative_gui_position.left
        }

    })

    -- frame.style.padding = 10

    local frame_scroll = frame.add({
        type = 'scroll-pane',
        name = 'frame-scroll',
        vertical_scroll_policy = 'auto',
        horizontal_scroll_policy = 'auto'
    })

    local tab_content = frame_scroll.add({
        type = "flow",
        name = "cloud_storage_gui_body"
    })

    tab_content.style.padding = 10
    tab_content.style.maximal_height = 1000
    tab_content.style.maximal_width = 500

    tab_content = tab_content.add({
        type = "table",
        name = "cloud-storage-content",
        column_count = 10,
        draw_horizontal_lines = true
    })

    tab_content.style.vertically_stretchable = true
    tab_content.style.horizontally_stretchable = true
    tab_content.style.horizontal_spacing = 1
    tab_content.style.vertical_spacing = 1

    -- local cloud_items = cloud_storage:get_items()
    for i = 1, 500 do
        tab_content.add({
            type = "sprite-button",
            sprite = "item/iron-plate",
            number = 100,
            -- tags = { item = item },
            style = 'inventory_slot'
        })
    end
end

---@param event EventData.on_gui_opened
function on_gui_opened(event)
    local player = game.players[event.player_index]

    if (player.opened_self == true and event.gui_type == defines.gui_type.controller) then
        fetch_content_storage_cloud()
        open_storage_cloud_ui(player)
    end

    items = player.get_max_inventory_index()
end

function on_gui_closed(event)
    destroy_storage_cloud_ui(game.players[event.player_index])
end

---@param event EventData.on_gui_click
function on_gui_click(event)
    local player = game.players[event.player_index]
    local element = event.element

    if (element.parent.name == "cloud-storage-content") then
        ---@type Cloud.StorageDetail
        local el = element.tags["item"]
        local stack = 1
        if game.item_prototypes[el.name] and game.item_prototypes[el.name].stack_size < el.count then
            stack = game.item_prototypes[el.name].stack_size
        end
        if game.item_prototypes[el.name] and game.item_prototypes[el.name].stack_size > el.count then
            stack = el.count
        end

        player.get_main_inventory().insert({
            name = el.name,
            count = stack
        })
        cloud_storage:remove(el)
    end
end

script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_gui_click, on_gui_click)

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
