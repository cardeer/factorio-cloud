cloud_storage = require("utils/cloud_storage")

function on_init()
    ---@type { [number]: Cloud.Player }
    storage.players = {}

    ---@type Cloud.Storage
    storage.cloud_items = {}

    storage.stacks_multiplier = 1
end

function on_load()
end

script.on_init(on_init)
script.on_load(on_load)
