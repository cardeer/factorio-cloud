---@type { [integer]: LuaGuiElement}
local relative = {}

---@param player LuaPlayer
function gui.cloud_storage.create(player)
    gui.cloud_storage.destroy(player)

    local frame = player.gui.relative.add({
        type = 'frame',
        name = constants.gui.cloud_storage.name .. "-" .. player.index,
        direction = 'vertical',
        caption = 'Cloud Storage',
        style = "character_gui_left_side",
        anchor = {
            gui = defines.relative_gui_type.controller_gui,
            position = defines.relative_gui_position.left
        }
    })
    relative[player.index] = frame

    frame.style.vertically_stretchable = true
    frame.style.horizontally_stretchable = true

    local frame_content = frame.add({
        type = "frame",
        style = "entity_frame"
    })

    local frame_scroll_content = frame_content.add({
        type = "scroll-pane"
    })

    local frame_footer = frame.add({
        type = 'frame',
        style = 'subfooter_frame'
    })

    -- frame_footer.style.horizontally_stretchable = true

    local footer_flow = frame_footer.add({
        type = 'flow',
        vertical_centering = true
    })

    footer_flow.style.horizontally_stretchable = true

    local qualities = prototypes.quality

    local buttons = {}

    for key, quality in pairs(qualities) do
        if key == 'quality-unknown' then
            goto continue
        end

        local button = footer_flow.add({
            type = 'button',
            name = 'cloud-storage-quality-button-' .. key .. "-" .. player.index,
            toggled = players:get(player.index).quality_filtered == key
        })

        button.style = 'tool_button'

        buttons[key] = button

        sprite = button.add({
            type = 'sprite',
            resize_to_sprite = false,
            sprite = 'quality/' .. key
        })

        sprite.style.size = {16, 16}

        gui.add_handler(player, defines.events.on_gui_click, button.name, function()
            players:get(player.index).quality_filtered = key

            for k, v in pairs(buttons) do
                v.toggled = k == players:get(player.index).quality_filtered
            end
        end)

        ::continue::
    end

    local column_length = 10

    local content = frame_scroll_content.add({
        type = "table",
        name = "cloud-storage-content" .. "-" .. player.index,
        column_count = column_length

    })
    content.style.vertically_stretchable = true
    content.style.vertical_spacing = 0
    content.style.horizontal_spacing = 0

    local quality = players:get(player.index).quality_filtered

    local item_count = 0
    for _, item in pairs(cloud:get_items(quality)) do
        item_count = item_count + 1
        local item_button = content.add({
            type = "sprite-button",
            name = 'cloud-storage-item-button-' .. item.name .. "-" .. player.index,
            sprite = "item/" .. item.name,
            number = item.count and item.count or 0,
            tags = {
                type = 'cloud-item-button',
                item = item
            },
            style = 'inventory_slot'
        })
        if players:get(player.index).quality_filtered ~= "normal" then
            sprite = item_button.add({
                type = 'sprite',
                resize_to_sprite = false,
                sprite = 'quality/' .. item.quality
            })
            sprite.style.size = {13, 13}
        end
        gui.add_handler(player, defines.events.on_gui_click, item_button.name, function()
            local inventory = player.get_main_inventory()

            if inventory ~= nil then
                cloud:move_to_inventory(inventory, item)
            end
        end)
    end

    if item_count < column_length then
        local count = column_length - item_count
        for i = 1, count do
            content.add({
                type = "sprite-button",
                style = 'inventory_slot'
            })
        end
    end
end

---@param player LuaPlayer
function gui.cloud_storage.destroy(player)
    if player.gui.relative.children[player.index] then
        player.gui.relative.children[player.index].destroy()
    end
    if relative[player.index] then
        relative[player.index].destroy()
    end
end

---@param player LuaPlayer
function gui.cloud_storage.reopen(player)
    if player and relative[player.index] then
        gui.cloud_storage.destroy(player)
        gui.cloud_storage.create(player)
    end
end
