---@type { [integer]: LuaGuiElement}
local relative = {}
---@type { [integer]: LuaEntity}
local entity_target = {}

---@param player LuaPlayer
---@param entity LuaEntity
function gui.container_filter_gui.create(player, entity)
    gui.container_filter_gui.destroy(player)

    local frame = player.gui.relative.add({
        type = 'frame',
        name = constants.gui.container_filter_gui.name .. "-" .. player.index,
        direction = 'vertical',
        caption = 'Downloader Filter',
        anchor = {
            gui = defines.relative_gui_type.container_gui,
            position = defines.relative_gui_position.right
        }
    })
    relative[player.index] = frame
    entity_target[player.index] = entity

    frame.style.padding = 10

    local frame_content = frame.add({
        type = "frame",
        style = "inside_shallow_frame_with_padding_and_vertical_spacing",
        direction = "horizontal"
    })
    frame_content.style.horizontal_align = "center"

    frame_content.add({
        type = "choose-elem-button",
        name = "cloud_download_filter-" .. player.index .. "-" .. entity.unit_number,
        elem_type = "item",
        item = storage_downloader.get_storage_filtered(entity.unit_number).filter,

    })

    local footer_flow = frame.add({
        type = 'flow',
        vertical_centering = true
    })

    footer_flow.style.horizontally_stretchable = true

    local qualities = prototypes.quality
    local buttons = {}

    for _quality in pairs(qualities) do
        if _quality == 'quality-unknown' then
            goto continue
        end

        local button = footer_flow.add({
            type = 'button',
            name = 'storage-container-quality-button-' .. _quality .. "-" .. player.index,
            toggled = storage_downloader.get_storage_filtered(entity.unit_number).quality == _quality
        })

        button.style = 'tool_button'

        buttons[_quality] = button
        sprite = button.add({
            type = 'sprite',
            resize_to_sprite = false,
            sprite = 'quality/' .. _quality
        })

        sprite.style.size = { 13, 13 }


        gui.add_handler(player, defines.events.on_gui_click, button.name, function()
            storage_downloader.get_storage_filtered(entity.unit_number).quality = _quality
            for k, v in pairs(buttons) do
                v.toggled = k == _quality
            end
        end)
        ::continue::
    end
end

---@param player LuaPlayer
function gui.container_filter_gui.get_entity_target(player)
    return entity_target[player.index]
end

---@param player LuaPlayer
function gui.container_filter_gui.destroy(player)
    if player.gui.relative.children[player.index] then
        player.gui.relative.children[player.index].destroy()
    end
    if relative[player.index] then
        relative[player.index].destroy()
    end
    if entity_target[player.index] then
        entity_target[player.index] = nil
    end
end
