require('types')

require('constants.general')
require('constants.items')

require('utils.cloud')
require('utils.player')

require('scripts.initialize')

require('scripts.events.player_joined')


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

function open_storage_cloud_ui(player)
    if player.gui.screen.cloud_storage_gui ~= nil then
        player.gui.screen.cloud_storage_gui.destroy()
    end

    ---@type LuaGuiElement
    frame = player.gui.screen.add({
        type = 'frame',
        name = 'cloud_storage_gui',
        direction = 'vertical',
        caption = 'Cloud Storage',
    })
    frame.location = { 50, 90 }
    frame.style.width = 500
    frame.style.height = 1000
    frame.style.maximal_height = 1000
    frame.style.maximal_width = 500
    frame.style.padding = 10

    frame_header = frame.add({
        type = "flow",
        name = "cloud_storage_gui_header",
        direction = "horizontal",
    })

    frame_body = frame.add({
        type = "flow",
        name = "cloud_storage_gui_body",
    })

    tab_public = frame_header.add({
        type = "tab",
        name = "cloud_public_storage_tab",
        caption = "Public Storage",
    })

    tab_private = frame_header.add({
        type = "tab",
        name = "cloud_private_storage_tab",
        caption = "Private Storage",
    })

    frame_body.style.padding = 10
    frame_body.style.maximal_height = 1000
    frame_body.style.maximal_width = 500

    tab_content = frame_body.add({
        type = "table",
        name = "cloud_storage_content",
        column_count = 10,
        draw_horizontal_lines = true,
    })
    tab_content.style.vertically_stretchable = true
    tab_content.style.horizontally_stretchable = true

    for i = 1, 100 do
        tab_content.add({
            type = "sprite-button",
            -- name = "cloud_storage_content_" .. i,
            sprite = "item/iron-plate",
            number = 100,
        })
    end
end

---@param event EventData.on_gui_opened
function on_gui_opened(event)
    local player = game.players[event.player_index]

    open_storage_cloud_ui(player)

    -- if player.character then
    -- print()
    -- end
    -- for item, value in pairs(player.get_main_inventory().get_contents()) do
    --     if value["name"] then
    --         print("item: " .. value["name"])
    --     end
    --     -- print("item idx : " .. value[0])
    --     -- for key, val in pairs(value) do
    --     --     print("item: " .. key .. " detail: " .. val)
    --     -- end
    -- end
    item = player.get_main_inventory().remove({ name = "iron-plate", count = 1 })
    -- if item then
    --     print("item: " .. item.name)
    -- end
end

function on_gui_closed(event)
    destroy_storage_cloud_ui(game.players[event.player_index])
end

function on_gui_click(event)
    local player = game.players[event.player_index]
    local element = event.element

    -- if element.name == "cloud_public_storage_tab" then
    --     print("cloud_public_storage_tab")
    -- elseif element.name == "cloud_private_storage_tab" then
    --     print("cloud_private_storage_tab")
    -- end
    print(element.name)
end

script.on_event(defines.events.on_built_entity, on_built_entity)
script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_gui_click, on_gui_click)

script.on_event(defines.events.on_player_main_inventory_changed, function(event)
    print("on_player_main_inventory_changed" .. event.name)
end)
script.on_event(defines.events.on_pre_player_crafted_item, function(event)
    print("on_picked_up_item" .. event.name)
end)
