---@param event EventData.on_pre_player_crafted_item
function events.on_pre_player_crafted_item(event)
    local player = game.players[event.player_index]

    if not settings.get_player_settings(player)["auto_download_ingredients"].value then
        return
    end

    local items = event.items.get_contents()
    local inventory = player.get_main_inventory()

    if not inventory then
        return
    end
    for _, item in pairs(items) do
        local item_count_on_cloud = cloud:item_count(item)
        local max_count_insert = item.count < item_count_on_cloud and item.count or item_count_on_cloud
        local insert_item = flib_table.deep_copy(item)
        insert_item.count = max_count_insert
        if max_count_insert > 0 and inventory.can_insert(insert_item) and cloud:can_download(insert_item) then
            inventory.insert(insert_item)
            cloud:download(insert_item)
        end
    end
end
