uploaded_event = script.generate_event_name()

local function do_upload()
    for _, surface in pairs(game.surfaces) do
        local surface_items = surface.find_entities_filtered({
            name = constants.items.cloud_storage_uploader.name
        })

        for _, container in pairs(surface_items) do
            local inventory = container.get_inventory(defines.inventory.chest)
            if inventory ~= nil then
                for _, item in pairs(inventory.get_contents()) do
                    if not cloud:is_full(item) then
                        cloud:upload({
                            name = item.name,
                            count = 1,
                            quality = item.quality
                        })

                        inventory.remove({
                            name = item.name,
                            count = 1,
                            quality = item.quality
                        })

                        script.raise_event(uploaded_event, {})
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
    -- fetch_gui()
end

script.on_event(uploaded_event, function()
    fetch_gui()
end)
