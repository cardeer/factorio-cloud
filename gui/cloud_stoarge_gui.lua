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
        anchor = {
            gui = defines.relative_gui_type.controller_gui,
            position = defines.relative_gui_position.left
        }
    })
    relative[player.index] = frame

    frame.style.vertically_stretchable = true
    frame.style.horizontally_stretchable = true

    local frame_scroll = frame.add({
        type = 'scroll-pane',
        name = 'frame-scroll' .. "-" .. player.index,
        vertical_scroll_policy = 'auto',
        horizontal_scroll_policy = 'auto'
    })

    local frame_footer = frame.add({
        type = 'frame',
        direction = 'horizontal',
        style = 'subfooter_frame'
    })

    frame_footer.style.horizontally_stretchable = true
    frame_footer.style.vertical_align = "bottom"

    local footer_flow = frame_footer.add({
        type = 'flow',
        vertical_centering = true
    })

    footer_flow.style.horizontally_stretchable = true

    qualities = prototypes.quality

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

    content = frame_scroll.add({
        type = "table",
        name = "cloud-storage-content" .. "-" .. player.index,
        column_count = 10,
        draw_horizontal_lines = true
    })

    local quality = players:get(player.index).quality_filtered

    for _, item in pairs(cloud:get_items(quality)) do
        -- local button = flib_gui.add(content, {
        --     type = "sprite-button",
        --     name = 'cloud-storage-item-button-' .. item.name .. "-" .. player.index,
        --     sprite = "item/" .. item.name,
        --     number = item.count and item.count or 0,
        --     tags = {
        --         item = item
        --     },
        --     style = 'inventory_slot'
        -- })

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

        gui.add_handler(player, defines.events.on_gui_click, item_button.name, function()
            local inventory = player.get_main_inventory()

            if inventory ~= nil then
                cloud:move_to_inventory(inventory, item)
            end
        end)
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
