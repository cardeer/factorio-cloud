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
                if not storage.container.filter[container.unit_number] or inventory:is_full() then
                    goto continue
                end
                ---@type Cloud.StorageDetail
                local item = {
                    name = storage.container.filter[container.unit_number],
                    quality = storage.container.quality[container.unit_number] or "normal",
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
    if event.tick % storage.upload_tick == 0 then
        do_upload()
    end

    if event.tick % storage.download_tick == 0 then
        do_download()
    end
end
