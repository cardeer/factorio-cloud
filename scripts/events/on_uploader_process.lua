events.on_uploader_process_event = script.generate_event_name()
local is_uploading = false

function events.on_uploader_process()
    if not is_uploading then
        is_uploading = true
        for _, inventory in pairs(storage_uploader.get_all()) do
            if inventory then
                for _, item in pairs(inventory.get_contents()) do
                    local upload_success = cloud:upload({
                        name = item.name,
                        count = 1,
                        quality = item.quality
                    })
                    if upload_success then
                        inventory.remove({
                            name = item.name,
                            count = 1,
                            quality = item.quality
                        })
                    end
                end
            end
        end
        is_uploading = false
    end
end
