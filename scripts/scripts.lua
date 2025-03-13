function on_init()
    ---@type Cloud.Storage
    storage.cloud_items = {}

    storage.stacks_multiplier = 1
    storage.upload_tick = 10
    storage.download_tick = 10
end

function on_load()
end
