local is_uploading = false
local is_downloading = false

local function do_upload()
    if is_uploading then return end
    is_uploading = true
    for _, inventory in pairs(storage_uploader.get_all()) do
        if not inventory then goto continue end
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
        :: continue ::
    end
    is_uploading = false
end

local function do_download()
    if is_downloading then return end
    is_downloading = true
    for unit_number, inventory in pairs(storage_downloader.get_all()) do
        if not inventory then goto continue end
        local filter_by = storage_downloader.get_storage_filtered(unit_number)
        if not filter_by.filter or inventory:is_full() then
            goto continue
        end
        ---@type Cloud.StorageDetail
        local item = {
            name = filter_by.filter,
            quality = filter_by.quality,
            count = 1
        }
        if cloud:can_download(item) and inventory.can_insert(item) then
            local downloaded = cloud:download(item)
            inventory.insert(downloaded)
        end
        ::continue::
    end
    is_downloading = false
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
