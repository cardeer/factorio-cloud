---@param player LuaPlayer
function gui.cloud_storage.create(player)
    local relative = player.gui.relative

    if relative[constants.gui.cloud_storage.name] then
        relative[constants.gui.cloud_storage.name].destroy()
    end

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

    frame.style.vertically_stretchable = true
    frame.style.horizontally_stretchable = true

    local frame_scroll = frame.add({
        type = 'scroll-pane',
        name = 'frame-scroll',
        vertical_scroll_policy = 'auto',
        horizontal_scroll_policy = 'auto'
    })

    frame_scroll.style.horizontally_stretchable = true

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
            name = 'cloud-storage-quality-button-' .. key,
            toggled = players:get(player.index).quality_filtered == key
        })

        button.style = 'tool_button'

        buttons[key] = button

        sprite = button.add({
            type = 'sprite',
            resize_to_sprite = false,
            sprite = 'quality/' .. key
        })

        sprite.style.size = {15, 15}

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
        name = "cloud-storage-content",
        column_count = 10,
        draw_horizontal_lines = true
    })

    local cloud_items = cloud:get_items()

    for _, item in pairs(cloud_items) do
        content.add({
            type = "sprite-button",
            sprite = "item/" .. key,
            number = cloud_items[key] and cloud_items[key].count or 0,
            -- tags = {
            --     item = item
            -- },
            style = 'inventory_slot'
        })
    end
end

---@param player LuaPlayer
function gui.cloud_storage.destroy(player)

end
