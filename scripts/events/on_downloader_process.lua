events.on_downloader_process_event = script.generate_event_name()
local is_download = false

function events.on_downloader_process()
    if not is_download then
        is_download = true
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
        is_download = false
    end
end
