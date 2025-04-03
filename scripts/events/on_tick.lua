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
                    end
                end
            end
        end
    end
end

local function do_download()
    for _, surface in pairs(game.surfaces) do
        local surface_items = surface.find_entities_filtered({
            name = constants.items.cloud_storage_downloader.name
        })
        for _, container in pairs(surface_items) do
            local inventory = container.get_inventory(defines.inventory.chest)
            if inventory ~= nil then
                if not storage_downloader.get(container.unit_number).filter or inventory:is_full() then
                    goto continue
                end
                ---@type Cloud.StorageDetail
                local item = {
                    name = storage_downloader.get(container.unit_number).filter,
                    quality = storage_downloader.get(container.unit_number).quality,
                    count = 1
                }
                if cloud:can_download(item) and inventory.can_insert(item) then
                    local downloaded = cloud:download(item)
                    inventory.insert(downloaded)
                end
                ::continue::
            end
        end
    end
end

---@param event EventData.on_tick
function events.on_tick(event)
    local tick_upload = settings.startup["cloud_storage_speed_upload"].value or 10
    if event.tick % tick_upload == 0 then
        do_upload()
    end

    local tick_download = settings.startup["cloud_storage_speed_download"].value or 10
    if event.tick % tick_download == 0 then
        do_download()
    end
end
