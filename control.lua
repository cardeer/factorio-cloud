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

---@param player LuaPlayer
function open_storage_cloud_ui(player)
    if player.gui.relative['cloud-storage-gui'] ~= nil then
        player.gui.relative['cloud-storage-gui'].destroy()
    end

    local items_per_row = 10

    ---@type LuaGuiElement
    local frame = player.gui.relative.add({
        type = 'frame',
        name = 'cloud-storage-gui',
        direction = 'vertical',
        caption = 'Cloud Storage',
        anchor = {
            gui = defines.relative_gui_type.controller_gui,
            position = defines.relative_gui_position.left
        }

    })

    frame.location = {50, 90}
    frame.style.maximal_width = 500
    -- frame.style.padding = 10

    local frame_scroll = frame.add({
        type = 'scroll-pane',
        name = 'frame-scroll',
        vertical_scroll_policy = 'auto-and-reserve-space',
        horizontal_scroll_policy = 'auto-and-reserve-space'
    })

    frame_scroll.style.width = items_per_row * (40 * player.display_scale) + (1 * (items_per_row - 1))

    local tab_content = frame_scroll.add({
        type = "table",
        name = "cloud-storage-content",
        column_count = 10,
        draw_horizontal_lines = true
    })
    tab_content.style.vertically_stretchable = true
    tab_content.style.horizontally_stretchable = true
    tab_content.style.horizontal_spacing = 1
    tab_content.style.vertical_spacing = 1

    for i = 1, 500 do
        local button = tab_content.add({
            type = "sprite-button",
            name = "cloud-storage-item" .. i,
            sprite = "item/cloud-storage",
            number = 100
        })

        button.style = 'inventory_slot'
    end
end

---@param event EventData.on_gui_opened
function on_gui_opened(event)
    local player = game.players[event.player_index]

    if (player.opened_self == true and event.gui_type == defines.gui_type.controller) then
        open_storage_cloud_ui(player)
    end

    item = player.get_main_inventory().remove({
        name = "iron-plate",
        count = 1
    })
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
    print('click ' .. element.name)
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
