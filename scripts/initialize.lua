cloud = require("utils.cloud")

function on_init()
    ---@type Cloud.Storage
    storage.cloud_items = {}

    storage.stacks_multiplier = 1
    storage.upload_tick = 5
    storage.download_tick = 5
end

function on_load()
end

script.on_init(on_init)
script.on_load(on_load)
