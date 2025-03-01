function on_init()
    ---@type Cloud.Storage
    storage.cloud_items = {}

    storage.stacks_multiplier = 1
    storage.gui_fetch_tick = 20
    storage.upload_tick = 10
    storage.download_tick = 10
end

function on_load()
end

script.on_init(on_init)
script.on_load(on_load)
