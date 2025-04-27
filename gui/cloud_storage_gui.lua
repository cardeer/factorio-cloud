---@type { [integer]: LuaGuiElement}
local relative = {}

---@type { [integer]: LuaGuiElement}
local display_content = {}

---@type { [integer]: string }
local current_display_quality = {}

---@type { [integer]: boolean }
local player_gui_opened = {}

---@param player LuaPlayer
function gui.cloud_storage_gui.render_content(player)
    if not display_content[player.index] then
        return
    end

    display_content[player.index].clear()
    local quality = players:get(player.index).quality_filtered
    current_display_quality[player.index] = quality
    local item_count = 0
    local column_length = 10
    local content = display_content[player.index].add({
        type = "table",
        name = "cloud-storage-content" .. "-" .. player.index,
        column_count = column_length

    })
    content.style.vertically_stretchable = true
    content.style.vertical_spacing = 0
    content.style.horizontal_spacing = 0

    -- sorting
    local items = cloud:get_items(quality)
    table.sort(items, function(a, b)
        local ga = prototypes.item[a.name].group.name
        local gb = prototypes.item[b.name].group.name
        if ga == gb then
            return a.name < b.name
        else
            return ga > gb
        end
    end)

    for _, item in pairs(items) do
        item_pt = prototypes.item[item.name]
        item_count = item_count + 1
        local item_button = content.add({
            type = "sprite-button",
            name = 'cloud-storage-item-button-' .. player.index .. "-" .. item.name,
            sprite = "item/" .. item.name,
            number = item.count and item.count or 0,
            tags = {
                type = 'cloud-item-button',
                item = item
            },
            style = 'inventory_slot',
            tooltip = { "", "[item=" .. item.name .. "]   ", -- icon
                "[font=default-bold][color=255,230,50]", item_pt.localised_name, "[/color][/font]" }
        })
        if players:get(player.index).quality_filtered ~= "normal" then
            sprite = item_button.add({
                type = 'sprite',
                resize_to_sprite = false,
                sprite = 'quality/' .. item.quality
            })
            sprite.style.size = { 13, 13 }
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
function gui.cloud_storage_gui.create(player)
    gui.cloud_storage_gui.destroy(player)
    player_gui_opened[player.index] = true
    if not cloud:is_available() then
        return
    end

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

    -- must update before render_content
    display_content[player.index] = frame_content.add({
        type = "scroll-pane"
    })
    gui.cloud_storage_gui.render_content(player)

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

        sprite.style.size = { 16, 16 }

        gui.add_handler(player, defines.events.on_gui_click, button.name, function()
            players:get(player.index).quality_filtered = key
            current_display_quality[player.index] = key

            for k, v in pairs(buttons) do
                v.toggled = k == players:get(player.index).quality_filtered
            end
            gui.cloud_storage_gui.render_content(player)
        end)

        ::continue::
    end
end

---@param player LuaPlayer
function gui.cloud_storage_gui.destroy(player)
    player_gui_opened[player.index] = false
    local gui = utils.filter(player.gui.relative.children, function(obj)
        return obj[2].name == constants.gui.cloud_storage.name .. '-' .. player.index
    end)

    for _, v in pairs(gui) do
        v.destroy()
    end

    if relative[player.index] then
        relative[player.index].destroy()
    end
end

---@param player LuaPlayer
function gui.cloud_storage_gui.reopen(player)
    if player and relative[player.index] then
        gui.cloud_storage_gui.destroy(player)
        gui.cloud_storage_gui.create(player)
    end
end

---@param item Cloud.StorageDetail
function gui.cloud_storage_gui.fetch_item_stack(item)
    for _, player in pairs(game.players) do
        if not player_gui_opened[player.index] then
            goto continue
        end
        if not display_content[player.index] or not display_content[player.index].valid then
            goto continue
        end
        if current_display_quality[player.index] ~= item.quality or not display_content[player.index].children then
            -- gui.cloud_storage_gui.render_content(player)
            goto continue
        end
        for _, el in pairs(display_content[player.index].children[1].children) do
            local button_name = 'cloud-storage-item-button-' .. player.index .. "-" .. item.name
            if el.name == button_name then
                el.number = cloud:item_count(item)
                goto continue
            end
        end
        gui.cloud_storage_gui.render_content(player)

        ::continue::
    end
end
