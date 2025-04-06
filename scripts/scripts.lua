function on_init()
    ---@type Cloud.Storage
    storage.cloud_items = {}
end

function on_load()
    if not storage.cloud_items then
        storage.cloud_items = {}
    end
end
