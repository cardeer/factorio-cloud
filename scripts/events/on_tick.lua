local function do_upload()
    for _, surface in pairs(game.surfaces) do
        for _, container in pairs(surface.find_entities_filtered(
            {
                name = constants.items.cloud_storage_uploader.name
            }
        )) do
            local inventory = container.get_inventory(defines.inventory.chest)
            if inventory ~= nil then
                for _, item in pairs(inventory.get_contents()) do
                    if not cloud:is_full({ name = item.name, quality = item.quality }) then
                        cloud:upload({ name = item.name, count = 1, quality = item.quality })
                        inventory.remove(
                            {
                                name = item.name,
                                count = 1,
                                quality = item.quality
                            }
                        )
                    end
                end
            end
        end
    end
end

local function do_download()

end

local function fetch_gui()
    for player_index, _ in pairs(players) do
        gui.cloud_storage.reopen(game.players[player_index])
    end
end

---@param event EventData.on_tick
function events.on_tick(event)
    if event.tick % storage.upload_tick == 0 then
        do_upload()
    end
    if event.tick % storage.download_tick == 0 then
        do_download()
    end
    if event.tick % storage.gui_fetch_tick == 0 then
        fetch_gui()
    end
end
