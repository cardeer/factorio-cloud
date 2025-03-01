---@param player LuaPlayer
function gui:create_storage_gui(player)
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

    local frame_scroll = frame.add({
        type = 'scroll-pane',
        name = 'frame-scroll',
        vertical_scroll_policy = 'auto',
        horizontal_scroll_policy = 'auto'
    })

    frame_scroll.style.padding = 12

    content = frame_scroll.add({
        type = "table",
        name = "cloud-storage-content",
        column_count = 10,
        draw_horizontal_lines = true
    })

    local cloud_items = cloud:get_items()

    for key, item in pairs(cloud_items) do
        content.add({
            type = "sprite-button",
            sprite = "item/" .. item.name,
            number = item.count,
            tags = {
                item = item
            },
            style = 'inventory_slot'
        })
    end
end
