function on_init()
    ---@type { [number]: Cloud.Player }
    storage.players = {}

    ---@type Cloud.Storage
    storage.cloud_items = {}
end

function on_load()
end

script.on_init(on_init)
script.on_load(on_load)
